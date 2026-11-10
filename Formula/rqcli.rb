class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.13.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.2/rqcli-1.13.2-darwin-arm64.tar.gz"
      sha256 "a22a7466210709e6f74197180c9a32bf8658b6bba29a13e8086fae31f1aeb4bc"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.2/rqcli-1.13.2-darwin-amd64.tar.gz"
      sha256 "aeaf1ed0d1245d8c03b5b44ce2e3a13b3e2ad3da44e1ac35c1338a54dd631868"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.2/rqcli-1.13.2-linux-arm64.tar.gz"
      sha256 "f7c4bd3f1f47e172a125d447b0b1fb251145b737138686fea7949fccfc7feb69"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.13.2/rqcli-1.13.2-linux-amd64.tar.gz"
      sha256 "6b7f5a49f90d8786335708b3f65c80a8bc52bf94b927e668507145eac5b39f58"
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
