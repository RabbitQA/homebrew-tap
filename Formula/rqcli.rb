class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/0.1.0/rqcli-0.1.0-darwin-arm64.tar.gz"
      sha256 "a90a2cd5050bfabd9e1d52029b04069798dd0a2103f6f3aa4a27c73c19e9a058"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/0.1.0/rqcli-0.1.0-darwin-amd64.tar.gz"
      sha256 "f0f89d2f9c18ec15d1a5e4e1aeab78439c410379066aba6ce79f361eccaca22b"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/0.1.0/rqcli-0.1.0-linux-arm64.tar.gz"
      sha256 "b41cc2b540351630ef6be78883729654abad0a86e734f7d7470fcb0c2345c2f0"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/0.1.0/rqcli-0.1.0-linux-amd64.tar.gz"
      sha256 "8ea6ba5fd6aa9808b8bc656597f3bb0eb4f5e97834e422ae065f7bbba3637ad7"
    end
  end

  def install
    bin.install "rqcli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rqcli --version")
  end
end
