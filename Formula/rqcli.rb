class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.13.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.0/rqcli-1.13.0-darwin-arm64.tar.gz"
      sha256 "c7a2831fc6e0f139e0511c7f0fa890069f1b9701554a73d096847bb981fcb8b5"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.0/rqcli-1.13.0-darwin-amd64.tar.gz"
      sha256 "015a7d4295f3ca9351ee30bdcdc76dcc655d89b35cbbc96bbf57cc67244cf812"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.0/rqcli-1.13.0-linux-arm64.tar.gz"
      sha256 "0cdfb8cbb57951ca16c41ce514c1fae5e72ad0a6e4e468c11726d99903138a1a"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.0/rqcli-1.13.0-linux-amd64.tar.gz"
      sha256 "176a619829ac654c1c26e341cf36ce65ead40000c424f53c7924323f21bd4635"
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
