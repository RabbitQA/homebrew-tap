class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.5.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.5.0/rqcli-1.5.0-darwin-arm64.tar.gz"
      sha256 "9529da898aeb3eb3486a8319795803b88bb42cf99bc905958bc8678fd4babb49"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.5.0/rqcli-1.5.0-darwin-amd64.tar.gz"
      sha256 "4b8b1f779eefba9a7ab0954969f1585a87d6a027c2089ce5ecb76dcdaf6bfd77"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.5.0/rqcli-1.5.0-linux-arm64.tar.gz"
      sha256 "542f495ba37d28a0eb7627af2c9f2f46119d671fb35011e64e1019f894ede043"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.5.0/rqcli-1.5.0-linux-amd64.tar.gz"
      sha256 "210853ccd1b6ad11c236ae39dfbdddad889ce52082832c8a9f7ec027c9b42b7f"
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
