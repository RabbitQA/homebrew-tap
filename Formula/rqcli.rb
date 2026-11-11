class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.15.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.0/rqcli-1.15.0-darwin-arm64.tar.gz"
      sha256 "e488741a1a76dcc83fd2000600b28518763e7b5ff778b924d8489ec4ed323fc0"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.0/rqcli-1.15.0-darwin-amd64.tar.gz"
      sha256 "045f6bc2640b82b8b3bb81bff6e6fe4bccb1683ca0e2d8bc5646290e9d1cdc5f"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.0/rqcli-1.15.0-linux-arm64.tar.gz"
      sha256 "a02320844a2a9f95c3b6ee0da68019a59f8eb7ede9289a4da330a58f03d8e84c"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.0/rqcli-1.15.0-linux-amd64.tar.gz"
      sha256 "92489402ca2bc30f6e2c2c22f22491a40fa3deacc877910e065b96cdb80c8d63"
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
