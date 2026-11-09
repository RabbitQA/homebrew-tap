class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.6.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.2/rqcli-1.6.2-darwin-arm64.tar.gz"
      sha256 "de9eb5f8f8692e2b77873575e93bb21799cfef596200c31aebb30c246511b1c9"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.2/rqcli-1.6.2-darwin-amd64.tar.gz"
      sha256 "63d3958d26d79aaafc3f5e4ad24725a81f3fdacf456abdf60b92cda47cc493e4"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.2/rqcli-1.6.2-linux-arm64.tar.gz"
      sha256 "6f1c371eb193aa67c965f68456864c34440fd83c2e4108f48de1de97856292f8"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.2/rqcli-1.6.2-linux-amd64.tar.gz"
      sha256 "63f19eb72f45c67ea36e69f59d2c409d91eca0dc0a322ab76f1bfdb484a8a3f5"
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
