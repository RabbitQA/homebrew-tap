class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.12.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.12.0/rqcli-1.12.0-darwin-arm64.tar.gz"
      sha256 "091a68cb985f5c083eae2a2ea99b72b8247f2224162ccb751f6f4d5751d32509"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.12.0/rqcli-1.12.0-darwin-amd64.tar.gz"
      sha256 "2bdbdd870b371fa598ae2f7072e7bfd8a7302b8dcde5dcc09b5d0ca2c80369e4"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.12.0/rqcli-1.12.0-linux-arm64.tar.gz"
      sha256 "c372c5777d59e0d4f63019bd665b6203d2c2554ce281b77a1d63260ed07aadad"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.12.0/rqcli-1.12.0-linux-amd64.tar.gz"
      sha256 "1566318d0dae0eadefcbb922874d396dda829c0835bc8192e59218312fbfd8be"
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
