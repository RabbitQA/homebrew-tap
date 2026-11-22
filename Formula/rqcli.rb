class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.52.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.52.3/rqcli-1.52.3-darwin-arm64.tar.gz"
      sha256 "69c412ee334e1dd8effa9e268b84b317a0be9b1c0e23d72807c2257d2469c0e4"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.52.3/rqcli-1.52.3-darwin-amd64.tar.gz"
      sha256 "e69a58eb4303a11af866e76fb92835ec23e2d49dbe8e38508d6f2efb9611df20"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.52.3/rqcli-1.52.3-linux-arm64.tar.gz"
      sha256 "aa447b713f54644b60c9c981e945463658162375f7e5cec72a27b07d7308b2b2"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.52.3/rqcli-1.52.3-linux-amd64.tar.gz"
      sha256 "94b52d772a5b1045ef81b5224e4855292f1edb705fdafd39709117471030e1cf"
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
