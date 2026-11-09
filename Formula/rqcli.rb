class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.6.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.0/rqcli-1.6.0-darwin-arm64.tar.gz"
      sha256 "da438879ff5a4b644bf118c53ee5d9cc32e5128ad9a4c1bfc3a73c789b8cfbee"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.0/rqcli-1.6.0-darwin-amd64.tar.gz"
      sha256 "2db2bac2e1b2e3f0549c415b2035c24c59251b28a65f76908d4a34d51c18ee18"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.0/rqcli-1.6.0-linux-arm64.tar.gz"
      sha256 "c0c8b5a51438ba9308573f42d1c2532c7e6de12c68916e9a7c78b801584a5309"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.6.0/rqcli-1.6.0-linux-amd64.tar.gz"
      sha256 "fb0299c0ffe4d93b283c617987078bca86c0125da1698231dc7dbbe187346a08"
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
