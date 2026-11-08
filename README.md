# RabbitQA Homebrew tap

Homebrew formula for `rqcli`, the RabbitQA command-line interface.

## Install

```sh
brew install rabbitqa/tap/rqcli
rqcli --version
rqcli --help
```

The formula installs a native binary for macOS or Linux on Apple Silicon/ARM64
or Intel/AMD x86-64. Node.js is not required for this installation method.

## Update

```sh
brew update
brew upgrade rabbitqa/tap/rqcli
```

## Agent guide

```sh
rqcli skills print
```

## Release automation

GitLab builds and tests the Go CLI and freezes a version, source SHA, pipeline/job
identity and checksums. A maintainer selects the verified default-branch pipeline's
manual `publish-rqcli` job. That job uploads immutable archives and sends this
repository a `release-request.json` on a `rqcli-publish/VERSION-JOB` branch based
on a pinned publisher commit. Only that JSON file may differ from the pinned code.

`publish-rqcli.yml` runs on GitHub-hosted runners in environment `rqcli-release`.
npm trusted publishing must authorize `RabbitQA/homebrew-tap`, that workflow file,
and that environment for `@rabbitqa/cli` and its six native packages. No npm token
is stored in either CI. The environment permits only `rqcli-publish/*` branches.

The workflow verifies checksums and package metadata, publishes the native
packages first, waits for npm's install metadata, then publishes the launcher.
It checks fresh anonymous npm installation and an isolated Homebrew tap including
shell completions. GitLab waits for this exact request commit's successful run,
updates `Formula/rqcli.rb`, and finally advances the download update manifest.

The `repository` field in npm packages identifies this **distribution repository**.
Go source is maintained in the private RabbitQA GitLab monorepo. Automatic npm
build provenance is disabled because GitHub publishes already built artifacts;
`release-plan.json` and `SHA256SUMS` retain their actual GitLab build identity.

A retry accepts an existing npm version only when its SHA-512 integrity matches.
Registry indexing can lag publication; wait or retry the same GitLab publication
job, without changing or republishing package bytes. A newer public version blocks
an older request. The GitLab job alone advances the tap and download update pointer.

The GitLab SSH deploy key grants write access only to this repository. Its private
half is protected and masked in GitLab's `release/version` environment; it is not
a GitHub personal token. Workflow changes require review, then updating the
pinned publisher SHA in GitLab. Request branches preserve publication evidence.
