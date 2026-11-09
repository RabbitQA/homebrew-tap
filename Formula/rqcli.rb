class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.0.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.0.0/rqcli-1.0.0-darwin-arm64.tar.gz"
      sha256 "cf0eade50184ee0bd8e1833fc2f3a079905b1d688a814d32a3fc817d1b0b7f55"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.0.0/rqcli-1.0.0-darwin-amd64.tar.gz"
      sha256 "a1d84a8506c688e8a4b94fcda1b09651f95ee88a1fca3eb8ac097297df04b929"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.0.0/rqcli-1.0.0-linux-arm64.tar.gz"
      sha256 "382823800f29a01a77af3a06c5b463dead2054e3e3e477f3d89b0c0dea7dd251"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.0.0/rqcli-1.0.0-linux-amd64.tar.gz"
      sha256 "c5d461e7399e323e7314f6e2171468340c4d164515e95ce18dca6afae3bbf1bc"
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
