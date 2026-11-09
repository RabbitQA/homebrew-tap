class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.4.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.1/rqcli-1.4.1-darwin-arm64.tar.gz"
      sha256 "88e39e5538cd7548911d4b8e2932d8f6b246b558e008448b7969b7bbda98055e"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.1/rqcli-1.4.1-darwin-amd64.tar.gz"
      sha256 "c3fbe2b286e43f1551d9b11ce357b3dbd171bac680f1e5ff5b4f47e203422391"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.1/rqcli-1.4.1-linux-arm64.tar.gz"
      sha256 "82dd5085c1b2a3652e6dcb5e4f8b7ff148041105a1094227bc1e40bd9aac63c3"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.1/rqcli-1.4.1-linux-amd64.tar.gz"
      sha256 "7843ff2f75712cfc8f42c662bbae6f65d8b44b2ba0d7405f0875ff10675bc554"
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
