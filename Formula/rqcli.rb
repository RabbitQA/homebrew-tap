class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.8.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.8.0/rqcli-1.8.0-darwin-arm64.tar.gz"
      sha256 "12d141b3146ae31e192d2c9e4717991146c8e89b4d2edf983eb6a699f0b97bcc"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.8.0/rqcli-1.8.0-darwin-amd64.tar.gz"
      sha256 "e99e01c3b3fa9ee308e6e789b2e4c2dfa9bae585cb45cad96228dfd187daaf8b"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.8.0/rqcli-1.8.0-linux-arm64.tar.gz"
      sha256 "05234218e5026a7f3c21cd70017c860352c24b0f727fdd93e5e1c7975bfde71c"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.8.0/rqcli-1.8.0-linux-amd64.tar.gz"
      sha256 "724b23956d7aa7f07570fa1ee9d8485efce0c8a7c9025e695daebf5d5c3406d2"
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
