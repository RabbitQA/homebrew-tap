class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.14.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.2/rqcli-1.14.2-darwin-arm64.tar.gz"
      sha256 "9d582c1bcd33ccf7722717ea1f5848facd4efac6bc177f4a228499d6b5c8bfb6"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.2/rqcli-1.14.2-darwin-amd64.tar.gz"
      sha256 "bda685e3a2ba21494538b1e725c60fcbef7b543cbf233e22d3b4d86d9abd0f9e"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.2/rqcli-1.14.2-linux-arm64.tar.gz"
      sha256 "091f9a8591519077f598876b451ff0ce327b67eadf236daadd93fe92309b81f9"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.2/rqcli-1.14.2-linux-amd64.tar.gz"
      sha256 "e57e0f12d353c0642383c07c1688813c3250ed781fd13f95e92abf203b2dd313"
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
