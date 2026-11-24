class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.62.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.62.1/rqcli-1.62.1-darwin-arm64.tar.gz"
      sha256 "2650719145038c11340d5cecc3a2eb75a8cb6210b3be682609e74cd7cdec162b"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.62.1/rqcli-1.62.1-darwin-amd64.tar.gz"
      sha256 "5f46366785812baaf588e0385620530e3a11377337fe13bbccf5e9e0a4fbb6cd"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.62.1/rqcli-1.62.1-linux-arm64.tar.gz"
      sha256 "ff7a0673836c3a4b181f9e993dd01196abe1f4c4d8a701eca006d4662d59996e"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.62.1/rqcli-1.62.1-linux-amd64.tar.gz"
      sha256 "c81e4beb1a3284e64a92fdb81b0300724a11cdaf903f222c13f11dc2470590c2"
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
