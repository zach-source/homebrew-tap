class Nixfleet < Formula
  desc "Fleet management CLI for deploying Nix configurations to non-NixOS hosts"
  homepage "https://github.com/zach-source/nix-fleet"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.1/nixfleet-darwin-arm64.tar.gz"
      sha256 "46c972621806e743c303a721e8b36f552433269a88c0aac79fb6c026fc72908f"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.1/nixfleet-darwin-amd64.tar.gz"
      sha256 "b7850c52f3a37d073f7a9bc63ced8e2dd2d2bb0faf17bfb8583ba1a1573eef0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.1/nixfleet-linux-arm64.tar.gz"
      sha256 "79025d961ad3faf3819d26cd47f6152a412aba5932f1f908a671e54ca7383bb8"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.1/nixfleet-linux-amd64.tar.gz"
      sha256 "ad9e1fdb3870107be328920d27fc98502f1ce9b59eaf24da7d26ec1bceb7b65a"
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
