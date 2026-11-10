class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.11.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.0/rqcli-1.11.0-darwin-arm64.tar.gz"
      sha256 "d32b3ddf7fb8f9557474956a31ddba6ad45479f2a26a995c4593cbe2cd863a44"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.0/rqcli-1.11.0-darwin-amd64.tar.gz"
      sha256 "08494a0fed4373ec88b3a4f86e5d1f65505be6fb3b4ae0019bed0bf9aee049c6"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.0/rqcli-1.11.0-linux-arm64.tar.gz"
      sha256 "0bf9ea9495e05ce2e40c7bc991089f0395774e9fc62122ca6b84cd948c8bddd0"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.0/rqcli-1.11.0-linux-amd64.tar.gz"
      sha256 "64594bcb698ff92643e766b6d051089ab72cb143ef12c51b483bad8a4d5b8268"
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
