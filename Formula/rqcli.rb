class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.17.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.17.0/rqcli-1.17.0-darwin-arm64.tar.gz"
      sha256 "ffe93db2dd7bf2c43680b6593408bc904d9a5cd70ffc2c36f45ac4b971d66eaa"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.17.0/rqcli-1.17.0-darwin-amd64.tar.gz"
      sha256 "f2a8ca4eb58043ccd2954621e2e2c0f29990b41ca328ac3d5a5ddd731dacdb8e"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.17.0/rqcli-1.17.0-linux-arm64.tar.gz"
      sha256 "54dff51cbdbe0b1ab40179ec9d834b5870deb12e7149b4d4d67c5ec444cdaad6"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.17.0/rqcli-1.17.0-linux-amd64.tar.gz"
      sha256 "6cf429bc6b5b3a7916e3dae212ff01de7e0d2da2afe2f11da12eb279f1e4507d"
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
