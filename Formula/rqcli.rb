class Rqcli < Formula
  desc "Manage RabbitQA tests, AI generation, reports and Device Farm"
  homepage "https://rabbitqa.com"
  version "1.14.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.1/rqcli-1.14.1-darwin-arm64.tar.gz"
      sha256 "8c643f2e0328f9a3546079d59bf72016b16fcc6e1cbfddead95b93ca645c2cfa"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.1/rqcli-1.14.1-darwin-amd64.tar.gz"
      sha256 "eaecfc7b5aa4e6bcdace517f6dba29e711f58974f00564a44298385a7177a533"
    end
  end

  on_linux do
    on_arm do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.1/rqcli-1.14.1-linux-arm64.tar.gz"
      sha256 "b4f0d00f3345d40e4e23fd271d8ed17801171a26c4bf74a07d4ed89ff74c3e54"
    end
    on_intel do
      url "https://downloads.rabbitqa.com/rqcli/releases/1.14.1/rqcli-1.14.1-linux-amd64.tar.gz"
      sha256 "ecd1501749033bc304d00fcee734f86bdb400f2977197985845659142d9cefc1"
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
