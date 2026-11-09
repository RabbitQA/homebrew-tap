class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.7.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.7.0/rqcli-1.7.0-darwin-arm64.tar.gz"
      sha256 "8f9c88d1468700a1022074e0cf92e063bc968613a76f3d4cd7c87632714d950c"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.7.0/rqcli-1.7.0-darwin-amd64.tar.gz"
      sha256 "58cfb272618a38f44214ce5abb018a3a4e41bbaa8649225322bd83f6129204ea"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.7.0/rqcli-1.7.0-linux-arm64.tar.gz"
      sha256 "a34e758d7dbe6bea068cfc0cc5a49c51fb5cdcb5fe034322c1f5befb0645a6d0"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.7.0/rqcli-1.7.0-linux-amd64.tar.gz"
      sha256 "e25060b6b30e2f0d6e0b7b8ce97c4b3a068b1cef04cb86ebeab29645d42bcb3b"
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
