class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.15.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.1/rqcli-1.15.1-darwin-arm64.tar.gz"
      sha256 "3b3ff8492bea3090df5d618f9734e98e55d20852a1ccbf1e2081b8d92074bd58"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.1/rqcli-1.15.1-darwin-amd64.tar.gz"
      sha256 "0a3fc42ca5296d42e5fee497c3a35f456d2184bfcecb2704afc844d170213170"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.1/rqcli-1.15.1-linux-arm64.tar.gz"
      sha256 "9e358bdffb2fc1f98bea64e45024d302f4ce04e982114034dc83288b371c4795"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.15.1/rqcli-1.15.1-linux-amd64.tar.gz"
      sha256 "7f1d4d8ad95f7a30f9ea12925c75a48813328480052d47f93b17cbd539023870"
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
