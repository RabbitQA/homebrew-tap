class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.78.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.78.0/rqcli-1.78.0-darwin-arm64.tar.gz"
      sha256 "8da2d91025bcff2752dfebdf421416a7ef24881a78052cf741bac9e49362c348"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.78.0/rqcli-1.78.0-darwin-amd64.tar.gz"
      sha256 "479b9e4f7c2ad323fa33b395f0d29db7ef9ef9e6d73a11386741337d5d5e41fb"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.78.0/rqcli-1.78.0-linux-arm64.tar.gz"
      sha256 "d076f9d912092d9ccce89f7d34e69b811c0faf51553b76368f4174fb898a933d"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.78.0/rqcli-1.78.0-linux-amd64.tar.gz"
      sha256 "83f341576380b8dc50c59a30fbf76ed42615319ac1d1b0cbb1afd29e85949dc5"
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
