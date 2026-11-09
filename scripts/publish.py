#!/usr/bin/env python3
"""Publish exact GitLab-built rqcli packages using this repository's npm OIDC."""
import base64
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tarfile
import tempfile
import time
from urllib.error import HTTPError
from urllib.parse import quote
from urllib.request import Request, urlopen

DOWNLOADS = "https://downloads.rabbitqa.com/rqcli/releases"
REGISTRY = "https://registry.npmjs.org"
REPOSITORY = "git+https://github.com/RabbitQA/homebrew-tap.git"
PLATFORMS = [f"{system}-{arch}" for system in ("linux", "darwin", "win32") for arch in ("x64", "arm64")]
SEMVER = r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"


def read_url(url, limit=64 * 1024 * 1024):
    with urlopen(Request(url, headers={"User-Agent": "rqcli-release", "Cache-Control": "no-cache"}), timeout=60) as response:
        body = response.read(limit + 1)
    if len(body) > limit:
        raise ValueError("Response exceeds download limit")
    return body


def validate_request(request, parent, changed, ref):
    required = {"version", "source_sha", "root_pipeline_id", "package_job_id", "publisher_sha", "checksums_sha256"}
    if set(request) != required or not re.fullmatch(SEMVER, request["version"]):
        raise ValueError("Invalid release request")
    for key, length in (("source_sha", 40), ("publisher_sha", 40), ("checksums_sha256", 64)):
        if not re.fullmatch(r"[0-9a-f]{" + str(length) + "}", request[key]):
            raise ValueError(f"Invalid {key}")
    for key in ("root_pipeline_id", "package_job_id"):
        if not re.fullmatch(r"[1-9][0-9]*", str(request[key])):
            raise ValueError(f"Invalid {key}")
    if parent != request["publisher_sha"] or changed != ["release-request.json"]:
        raise ValueError("Request must change only release-request.json on the pinned publisher commit")
    if not re.fullmatch(r"refs/heads/rqcli-publish/" + re.escape(request["version"]) + r"-[1-9][0-9]*", ref):
        raise ValueError("Unexpected request branch")


def checksums(data, expected):
    if hashlib.sha256(data).hexdigest() != expected:
        raise ValueError("Release checksum manifest does not match the GitLab request")
    result = {}
    for line in data.decode().splitlines():
        match = re.fullmatch(r"([0-9a-f]{64})  ([A-Za-z0-9][A-Za-z0-9._-]*)", line)
        if not match or match[2] in result:
            raise ValueError("Invalid or duplicate checksum entry")
        result[match[2]] = match[1]
    return result


def validate_package(path, name, version):
    with tarfile.open(path, "r:gz") as archive:
        members = archive.getmembers()
        native = name != "@rabbitqa/cli"
        binary = "rqcli.exe" if "win32" in name else "rqcli"
        expected_files = {"package/package.json", "package/" + binary} if native else {
            "package/package.json", "package/run.cjs", "package/README.md"}
        if len(members) != len(expected_files) or {m.name for m in members} != expected_files or any(
                not m.isfile() or m.size > 64 * 1024 * 1024 for m in members):
            raise ValueError("Unexpected package contents")
        manifest_member = archive.getmember("package/package.json")
        if manifest_member.size > 65536:
            raise ValueError("Oversized package metadata")
        manifest = json.load(archive.extractfile(manifest_member))
    if manifest.get("name") != name or manifest.get("version") != version:
        raise ValueError("Package identity does not match the request")
    if manifest.get("repository", {}).get("url") != REPOSITORY:
        raise ValueError("Package repository must match its trusted publisher")
    if any(key in manifest for key in ("scripts", "dependencies", "devDependencies")):
        raise ValueError("Unexpected lifecycle hooks or dependencies")
    if native:
        system, arch = name.removeprefix("@rabbitqa/cli-").split("-")
        if manifest.get("os") != [system] or manifest.get("cpu") != [arch] or "optionalDependencies" in manifest:
            raise ValueError("Invalid platform package")
    elif manifest.get("optionalDependencies") != {f"@rabbitqa/cli-{p}": version for p in PLATFORMS} or manifest.get("bin") != {"rqcli": "run.cjs"}:
        raise ValueError("Launcher must pin all six native packages to the same version")


def metadata(name, version=None):
    url = REGISTRY + "/" + quote(name, safe="") + ("/" + version if version else "")
    try:
        return json.loads(read_url(url, 8 * 1024 * 1024))
    except HTTPError as error:
        if error.code == 404:
            return None
        raise


def assert_integrity(document, integrity):
    if document.get("dist", {}).get("integrity") != integrity:
        raise ValueError("Published version has different bytes; immutable versions cannot be replaced")


def publish_package(path, name, version):
    integrity = "sha512-" + base64.b64encode(hashlib.sha512(path.read_bytes()).digest()).decode()
    document = metadata(name, version)
    if document:
        assert_integrity(document, integrity)
        print(f"Already accepted: {name}@{version}", flush=True)
    else:
        # No NODE_AUTH_TOKEN: npm exchanges the GitHub OIDC identity itself.
        subprocess.run(["npm", "publish", str(path), "--access", "public", "--ignore-scripts",
                        "--registry", REGISTRY], check=True, timeout=180)
    return integrity


def wait_installable(packages, version, timeout=900):
    deadline = time.monotonic() + timeout
    remaining = dict(packages)
    while remaining:
        for name, integrity in list(remaining.items()):
            document = metadata(name) or {}
            installed = document.get("versions", {}).get(version)
            if installed:
                assert_integrity(installed, integrity)
                latest = document.get("dist-tags", {}).get("latest")
                if latest != version:
                    raise ValueError(f"{name}: latest points at {latest}, expected {version}")
                del remaining[name]
        if remaining:
            if time.monotonic() >= deadline:
                raise TimeoutError(f"npm has not made these packages installable: {', '.join(remaining)}")
            print(f"Waiting for npm indexing: {', '.join(remaining)}", flush=True)
            time.sleep(15)


def verify_install(version, artifacts):
    with tempfile.TemporaryDirectory(prefix="rqcli-install-") as directory:
        env = {**os.environ, "NPM_CONFIG_USERCONFIG": directory + "/user.npmrc",
               "NPM_CONFIG_GLOBALCONFIG": directory + "/global.npmrc",
               "NPM_CONFIG_CACHE": directory + "/cache", "RQCLI_CONFIG_DIR": directory + "/config"}
        for key in ("NODE_AUTH_TOKEN", "NPM_TOKEN", "ACTIONS_ID_TOKEN_REQUEST_TOKEN", "ACTIONS_ID_TOKEN_REQUEST_URL"):
            env.pop(key, None)
        output = subprocess.check_output(["npm", "exec", "--yes", f"--package=@rabbitqa/cli@{version}",
                                          "--", "rqcli", "--version"], cwd=directory, env=env, text=True, timeout=180)
        if output.strip() != "rqcli version " + version:
            raise ValueError(f"Unexpected npm executable: {output}")
    subprocess.run(["brew", "tap-new", "--no-git", "rabbitqa/ci-validation"], check=True)
    tap = Path(subprocess.check_output(["brew", "--repository", "rabbitqa/ci-validation"], text=True).strip())
    shutil.copyfile(artifacts / "rqcli.rb", tap / "Formula/rqcli.rb")
    subprocess.run(["brew", "install", "--formula", "rabbitqa/ci-validation/rqcli"], check=True, timeout=300)
    subprocess.run(["brew", "test", "rabbitqa/ci-validation/rqcli"], check=True, timeout=120)
    prefix = Path(subprocess.check_output(["brew", "--prefix", "rabbitqa/ci-validation/rqcli"], text=True).strip())
    for path in ("etc/bash_completion.d/rqcli", "share/zsh/site-functions/_rqcli", "share/fish/vendor_completions.d/rqcli.fish"):
        if not (prefix / path).is_file():
            raise ValueError(f"Missing Homebrew completion: {path}")


def main():
    request = json.loads(Path("release-request.json").read_text())
    parent = subprocess.check_output(["git", "rev-parse", "HEAD^"], text=True).strip()
    changed = subprocess.check_output(["git", "diff", "--name-only", "HEAD^", "HEAD"], text=True).splitlines()
    validate_request(request, parent, changed, os.environ["GITHUB_REF"])
    version = request["version"]
    base = f"{DOWNLOADS}/{version}"
    sums = checksums(read_url(base + "/SHA256SUMS", 65536), request["checksums_sha256"])
    with tempfile.TemporaryDirectory(prefix="rqcli-artifacts-") as directory:
        artifacts = Path(directory)
        names = [f"@rabbitqa/cli-{p}" for p in PLATFORMS] + ["@rabbitqa/cli"]
        files = [f"{name.removeprefix('@').replace('/', '-')}-{version}.tgz" for name in names]
        for filename in files + ["rqcli.rb", "release-plan.json"]:
            body = read_url(base + "/" + filename)
            if hashlib.sha256(body).hexdigest() != sums.get(filename):
                raise ValueError(f"Checksum mismatch: {filename}")
            (artifacts / filename).write_bytes(body)
        plan = json.loads((artifacts / "release-plan.json").read_text())
        for key in ("version", "source_sha", "root_pipeline_id", "package_job_id"):
            if str(plan[key]) != str(request[key]):
                raise ValueError("GitLab artifact identity does not match the release request")
        if str(plan["project_id"]) != "12" or not plan["publishable"]:
            raise ValueError("Not a publishable RabbitQA build")
        for name, filename in zip(names, files):
            validate_package(artifacts / filename, name, version)
            existing = metadata(name) or {}
            latest = existing.get("dist-tags", {}).get("latest", "0.0.0")
            if tuple(map(int, latest.split("."))) > tuple(map(int, version.split("."))):
                raise ValueError(f"Refusing to downgrade {name} from {latest}")
        natives = {name: publish_package(artifacts / filename, name, version) for name, filename in zip(names[:-1], files[:-1])}
        wait_installable(natives, version)
        launcher = publish_package(artifacts / files[-1], names[-1], version)
        wait_installable({names[-1]: launcher}, version)
        verify_install(version, artifacts)
        print(f"Verified npm and Homebrew installation of rqcli {version}", flush=True)


if __name__ == "__main__":
    main()
