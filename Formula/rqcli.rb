class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.9.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.0/rqcli-1.9.0-darwin-arm64.tar.gz"
      sha256 "fafb382f1843e62f04e67567b308d0e5cdb68c1ab976fefdfc9d132b065f34cd"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.0/rqcli-1.9.0-darwin-amd64.tar.gz"
      sha256 "0c25ed989abcc134d0390fa66b8fc42a0e97913d5977153d5bf571025fb7d801"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.0/rqcli-1.9.0-linux-arm64.tar.gz"
      sha256 "1ca4bbe43077854d8aed32f884a15c68bb10a744b28753e2245753b03464fe05"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.9.0/rqcli-1.9.0-linux-amd64.tar.gz"
      sha256 "14102d1315963abf543e27d07dde0abe11e14bc9cf291ca8278ae9b4fe8ab8e6"
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
