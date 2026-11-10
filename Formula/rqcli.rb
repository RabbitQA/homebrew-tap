class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.13.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.1/rqcli-1.13.1-darwin-arm64.tar.gz"
      sha256 "bc08d406ee15230239039e5d339260084ccab90825fa583d352e2b28fcf23006"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.1/rqcli-1.13.1-darwin-amd64.tar.gz"
      sha256 "456d5e06487b4bfc10a28e200a5bbea591662a309c36871d14bc62964a61867b"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.1/rqcli-1.13.1-linux-arm64.tar.gz"
      sha256 "8d7eb327f86f33b12912eb6984387d5761295aa834bb4b210875d32eeceb9084"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.1/rqcli-1.13.1-linux-amd64.tar.gz"
      sha256 "9e191e6c413351db3d285d4a5ef8049d1658b3e88dd8f29891c0cbb5e80fad7a"
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
