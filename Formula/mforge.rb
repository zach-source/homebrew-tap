class Mforge < Formula
  desc "CLI that orchestrates Claude Code agents as a multi-role system for microservices"
  homepage "https://github.com/zach-source/microforge"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/microforge/releases/download/v0.1.0/mforge-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/zach-source/microforge/releases/download/v0.1.0/mforge-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/microforge/releases/download/v0.1.0/mforge-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/zach-source/microforge/releases/download/v0.1.0/mforge-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "mforge-darwin-arm64" => "mforge" if Hardware::CPU.arm? && OS.mac?
    bin.install "mforge-darwin-amd64" => "mforge" if Hardware::CPU.intel? && OS.mac?
    bin.install "mforge-linux-arm64" => "mforge" if Hardware::CPU.arm? && OS.linux?
    bin.install "mforge-linux-amd64" => "mforge" if Hardware::CPU.intel? && OS.linux?
  end

  test do
    assert_match "mforge", shell_output("#{bin}/mforge --help")
    assert_match version.to_s, shell_output("#{bin}/mforge --version")
  end
end
