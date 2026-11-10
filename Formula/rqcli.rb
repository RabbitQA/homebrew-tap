class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.9.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.1/rqcli-1.9.1-darwin-arm64.tar.gz"
      sha256 "9599d70dcacc9b9d9ee9baa2ab543a1e06ff4b7054687ee98cbeffb397478a86"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.1/rqcli-1.9.1-darwin-amd64.tar.gz"
      sha256 "9b07420ac8c6d11bb98cce94884b238117eea336b0e415b65d3a7e8df1cf6479"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.1/rqcli-1.9.1-linux-arm64.tar.gz"
      sha256 "7141257f2e38e482480c01e18c5de7b2ee991fad85c4a0a6553ca0b678750ed4"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.1/rqcli-1.9.1-linux-amd64.tar.gz"
      sha256 "c4aab8d86733d61db726d82f458f9ffec4ec63ba810ed5a4fb066d4d23ae5b56"
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
