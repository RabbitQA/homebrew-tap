import base64
import hashlib
import io
import json
from pathlib import Path
import tarfile
import tempfile
import unittest
from unittest.mock import patch

import publish


class PublishTests(unittest.TestCase):
    def test_request_is_bound_to_pinned_code_and_exact_build(self):
        request = {"version": "0.2.0", "source_sha": "a" * 40, "publisher_sha": "b" * 40,
                   "checksums_sha256": "c" * 64, "root_pipeline_id": 10, "package_job_id": 20}
        publish.validate_request(request, "b" * 40, ["release-request.json"], "refs/heads/rqcli-publish/0.2.0-30")
        for invalid in ({**request, "version": "../latest"}, {**request, "publisher_sha": "c" * 40},
                        {**request, "package_job_id": "20/other"}, {**request, "url": "https://elsewhere"}):
            with self.assertRaises(ValueError):
                publish.validate_request(invalid, "b" * 40, ["release-request.json"], "refs/heads/rqcli-publish/0.2.0-30")
        with self.assertRaises(ValueError):
            publish.validate_request(request, "b" * 40, ["release-request.json", "scripts/publish.py"], "refs/heads/rqcli-publish/0.2.0-30")

    def test_checksum_manifest_rejects_changes_traversal_and_duplicates(self):
        valid = ("a" * 64 + "  package.tgz\n").encode()
        self.assertEqual({"package.tgz": "a" * 64}, publish.checksums(valid, hashlib.sha256(valid).hexdigest()))
        with self.assertRaises(ValueError):
            publish.checksums(valid, "b" * 64)
        for data in (valid * 2, valid.replace(b"package.tgz", b"../package.tgz")):
            with self.assertRaises(ValueError):
                publish.checksums(data, hashlib.sha256(data).hexdigest())

    def test_packages_require_exact_dependencies_no_hooks_and_no_links(self):
        manifest = {"name": "@rabbitqa/cli", "version": "0.2.0", "repository": {"url": publish.REPOSITORY},
                    "bin": {"rqcli": "run.cjs"},
                    "optionalDependencies": {"@rabbitqa/cli-" + p: "0.2.0" for p in publish.PLATFORMS}}
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "cli.tgz"
            for change, valid in (({}, True), ({"scripts": {"postinstall": "curl bad"}}, False),
                                  ({"optionalDependencies": {}}, False), ({"repository": {"url": "other"}}, False)):
                with tarfile.open(path, "w:gz") as archive:
                    for name, data in {"package.json": json.dumps({**manifest, **change}).encode(),
                                       "run.cjs": b"", "README.md": b""}.items():
                        info = tarfile.TarInfo("package/" + name)
                        info.size = len(data)
                        archive.addfile(info, io.BytesIO(data))
                if valid:
                    publish.validate_package(path, "@rabbitqa/cli", "0.2.0")
                else:
                    with self.assertRaises(ValueError):
                        publish.validate_package(path, "@rabbitqa/cli", "0.2.0")

    def test_retry_does_not_republish_accepted_versions(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "cli.tgz"
            path.write_bytes(b"package")
            integrity = "sha512-" + base64.b64encode(hashlib.sha512(b"package").digest()).decode()
            with patch.object(publish, "metadata", return_value={"dist": {"integrity": integrity}}), patch.object(publish.subprocess, "run") as run:
                self.assertEqual(integrity, publish.publish_package(path, "@rabbitqa/cli", "0.2.0"))
                run.assert_not_called()
            with patch.object(publish, "metadata", return_value={"dist": {"integrity": "different"}}):
                with self.assertRaises(ValueError):
                    publish.publish_package(path, "@rabbitqa/cli", "0.2.0")

    def test_publication_waits_for_install_packument(self):
        ready = {"dist-tags": {"latest": "0.2.0"}, "versions": {"0.2.0": {"dist": {"integrity": "expected"}}}}
        with patch.object(publish, "metadata", side_effect=[None, {"versions": {}}, ready]), patch.object(publish.time, "sleep") as sleep:
            publish.wait_installable({"@rabbitqa/cli": "expected"}, "0.2.0")
            self.assertEqual(2, sleep.call_count)
        with patch.object(publish, "metadata", return_value=None):
            with self.assertRaises(TimeoutError):
                publish.wait_installable({"@rabbitqa/cli": "expected"}, "0.2.0", timeout=0)


if __name__ == "__main__":
    unittest.main()
