class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.74.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.74.0/rqcli-1.74.0-darwin-arm64.tar.gz"
      sha256 "60b596ce222f71d7e4f586f62f31bbfb29de0449114abee18f80841804998218"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.74.0/rqcli-1.74.0-darwin-amd64.tar.gz"
      sha256 "3a1d6a695d4931ac1afd8a5be4fba3f29da7628432925b08ccb9a21a1157af3c"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.74.0/rqcli-1.74.0-linux-arm64.tar.gz"
      sha256 "2db634dea90b5ffff55325ffba5f873e011e142e8bd36d3c69364a1f85b7426d"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.74.0/rqcli-1.74.0-linux-amd64.tar.gz"
      sha256 "24b6cffd59596181c9b19e24fd26d383b13b7a0de01b77818adfccd51b2a160d"
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
