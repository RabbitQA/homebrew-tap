class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.11.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.1/rqcli-1.11.1-darwin-arm64.tar.gz"
      sha256 "0bd5c9a8ee71385887573962d11bace6322c8b13c355c498c3d26863ce0d1297"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.1/rqcli-1.11.1-darwin-amd64.tar.gz"
      sha256 "046bea5c03e6529df11e2510b7367790dcdc2f5bee46dce8fbcb812bd61d0df1"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.1/rqcli-1.11.1-linux-arm64.tar.gz"
      sha256 "c0159af74104d4b55ba5b6dd16f5210e2f902715941eba198820c3dac7682ceb"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.11.1/rqcli-1.11.1-linux-amd64.tar.gz"
      sha256 "45472e63443f81dc4e869e2d35ba5985c5342d6766ec3cbff8e10fd4e0fe68c0"
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
