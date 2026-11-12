class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.18.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.18.3/rqcli-1.18.3-darwin-arm64.tar.gz"
      sha256 "b6a19847e3c30c41cfae41df1356e535ccd46aab9d10b61ea16b64cb47b558d0"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.18.3/rqcli-1.18.3-darwin-amd64.tar.gz"
      sha256 "ac9b37afdd6f9889618711b6dc72fb94b8b21e6402f85ae8552b11dc80edc0a8"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.18.3/rqcli-1.18.3-linux-arm64.tar.gz"
      sha256 "f31e9cf7bce6eb061928f5701096a57e9bab9e43cecf19c0b042fc2de5a44128"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.18.3/rqcli-1.18.3-linux-amd64.tar.gz"
      sha256 "c389338506b82126bf7271258b43d6ccf44ef0b4838c04d968480222cbc2c2d9"
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
