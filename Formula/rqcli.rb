class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.4.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.2/rqcli-1.4.2-darwin-arm64.tar.gz"
      sha256 "3cc4ed7087030877d6dbe0f35167deea58bb8f218ff4a5830a70c0d3e3e0138b"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.2/rqcli-1.4.2-darwin-amd64.tar.gz"
      sha256 "7e26efd7fb0361032e5289abee7e1417440c82e7ff8acc16b7cf380e48871360"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.2/rqcli-1.4.2-linux-arm64.tar.gz"
      sha256 "6e549e35f7f64f0d64196a2eba31240fae07ebb14e457e2c8643dcb6733e7a0a"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.4.2/rqcli-1.4.2-linux-amd64.tar.gz"
      sha256 "d3f52416302990ea123717cae0c1535edd31755fd073adf6b8dc7dee196f8a4b"
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
