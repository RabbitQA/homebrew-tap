class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.10.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.10.0/rqcli-1.10.0-darwin-arm64.tar.gz"
      sha256 "79462c575c4e8834a1c6701d321e0c9dec086d32daeec97cb4735ed7fe282e5c"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.10.0/rqcli-1.10.0-darwin-amd64.tar.gz"
      sha256 "48db68761d36be995ab715cf3f6bc37d629cc154af182afbea7483d4f41235dc"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.10.0/rqcli-1.10.0-linux-arm64.tar.gz"
      sha256 "5c02de69de1f52edc0211033f58bc21dd21086acd56cbbb0931e44edce063d32"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.10.0/rqcli-1.10.0-linux-amd64.tar.gz"
      sha256 "108be71df7a01ba349ed84c6fc4656a0a1cb290c5b870d56d3210708f04eba7c"
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
