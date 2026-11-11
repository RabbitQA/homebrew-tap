class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.16.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.1/rqcli-1.16.1-darwin-arm64.tar.gz"
      sha256 "b0e114a543053b615ee32312df2488e3b4240973f5ae7f8b541d9675caa70196"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.1/rqcli-1.16.1-darwin-amd64.tar.gz"
      sha256 "cd3b91d8a5b45a7565de91d9423db9cf6167df88aef77755f5fc34b43846436e"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.1/rqcli-1.16.1-linux-arm64.tar.gz"
      sha256 "5d0a239e148be4ecdb22a942c45dbed0bcccb15aeec560b21649e1e759ed2913"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.1/rqcli-1.16.1-linux-amd64.tar.gz"
      sha256 "560c5386917babcf434037dfe56530eb7b9052a435f050fb618b9c0d8cd0e8e1"
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
