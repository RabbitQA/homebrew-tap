class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.6.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.1/rqcli-1.6.1-darwin-arm64.tar.gz"
      sha256 "57954cd66c1a731622b4dee71dbfddccc8b06dacbdc0571e88a327a3cbd7c91e"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.1/rqcli-1.6.1-darwin-amd64.tar.gz"
      sha256 "49eb90d8670169d0c57a61d4275124447bee9c8f959812da0f6f0d64b8fbac96"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.1/rqcli-1.6.1-linux-arm64.tar.gz"
      sha256 "32df93de4c876da7042a101dccacd79b4560801fe98f63d1cf973c86c3fae903"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.1/rqcli-1.6.1-linux-amd64.tar.gz"
      sha256 "7ac475e4870da926ac8d22aba51e26186e23bb3b235a26b3ac55c97784913ff6"
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
