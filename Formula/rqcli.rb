class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.13.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.3/rqcli-1.13.3-darwin-arm64.tar.gz"
      sha256 "fd680dad09aa21c1d2bdc18d045335b78ce0ede6376541c6f3e5dbc2c84d8f5d"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.3/rqcli-1.13.3-darwin-amd64.tar.gz"
      sha256 "f5167da63e005b09f8d58bf8a2b09245b962f0d1777386ef65bb61a2d403a609"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.3/rqcli-1.13.3-linux-arm64.tar.gz"
      sha256 "78d75eba64f6005384b6d00cd6c56eb18e2f02cbb419558bc9f178dd3f8e722f"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.3/rqcli-1.13.3-linux-amd64.tar.gz"
      sha256 "30838789eebaeea6ab0ec901ef03382081c8bc7ca40136532b0d7ee4210f8769"
    end
  end

  def install
    bin.install "rqcli"
    generate_completions_from_executable(bin/"rqcli", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rqcli --version")
    assert_match "--timeout", shell_output("#{bin}/rqcli __complete runs wait --t")
  end
end
