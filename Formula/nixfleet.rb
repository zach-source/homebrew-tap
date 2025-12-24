class Nixfleet < Formula
  desc "Fleet management CLI for deploying Nix configurations to non-NixOS hosts"
  homepage "https://github.com/zach-source/nix-fleet"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.0/nixfleet-darwin-arm64.tar.gz"
      sha256 "64476cc82186b520c3bee610150d266679eb51c51c9eee6b113525f24a1ba5f1"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.0/nixfleet-darwin-amd64.tar.gz"
      sha256 "b052d9a9d50344efa94770cb6a3a3c03ecb3c0462bc2a21dbc786aab16dcb2bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.0/nixfleet-linux-arm64.tar.gz"
      sha256 "3f5d5900131bbb662774db48e0f9586aa1619806bfaedefb8193e75823f2da60"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.0/nixfleet-linux-amd64.tar.gz"
      sha256 "c667f837ee7358895b523643d71e9fe73b71c7ac2d32723b4995a1ec302a6e7e"
    end
  end

  def install
    bin.install "nixfleet-darwin-arm64" => "nixfleet" if Hardware::CPU.arm? && OS.mac?
    bin.install "nixfleet-darwin-amd64" => "nixfleet" if Hardware::CPU.intel? && OS.mac?
    bin.install "nixfleet-linux-arm64" => "nixfleet" if Hardware::CPU.arm? && OS.linux?
    bin.install "nixfleet-linux-amd64" => "nixfleet" if Hardware::CPU.intel? && OS.linux?
  end

  test do
    assert_match "nixfleet", shell_output("#{bin}/nixfleet --help")
    assert_match version.to_s, shell_output("#{bin}/nixfleet --version")
  end
end
