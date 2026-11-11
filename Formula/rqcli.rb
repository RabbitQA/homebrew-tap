class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.16.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.0/rqcli-1.16.0-darwin-arm64.tar.gz"
      sha256 "7d8a64ec5ae4a1b6ba578f54e3224e2f9fcd8952589c5c0ebda1fb9f0cdb6b1b"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.0/rqcli-1.16.0-darwin-amd64.tar.gz"
      sha256 "a29513c7467f91a5537f0e53e532a854dad28e948ca8b308d270f5ca33b48b9f"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.0/rqcli-1.16.0-linux-arm64.tar.gz"
      sha256 "5b0f47c1c81f6dff5b96987c03323109cc6b24d51ec22b90ace0ac8958d7ec0e"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.16.0/rqcli-1.16.0-linux-amd64.tar.gz"
      sha256 "fceb8253e0e93ec681c1ed98944aa3fc3c9f8993b6cc8c18dc79fd42109a6a0e"
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
