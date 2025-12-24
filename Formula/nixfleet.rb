class Nixfleet < Formula
  desc "Fleet management CLI for deploying Nix configurations to non-NixOS hosts"
  homepage "https://github.com/zach-source/nix-fleet"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.4/nixfleet-darwin-arm64.tar.gz"
      sha256 "3f16119413816db1460999ad02fef2a1b6a786bc6ed218804da36d9e3b5ccc01"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.4/nixfleet-darwin-amd64.tar.gz"
      sha256 "3bcdfd4c4805e97683e027db121b175d5dd0bd9ff6d32f65c2df1f7334d40a8d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.4/nixfleet-linux-arm64.tar.gz"
      sha256 "06e834e29d7149191102e984d737fb0b38dce4a20788aa982b734972a5eda6d7"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.4/nixfleet-linux-amd64.tar.gz"
      sha256 "22214e955a1b8b71633f5247853e05a1aceab19553f489bd35b55e5419ebf9d2"
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
