class Nixfleet < Formula
  desc "Fleet management CLI for deploying Nix configurations to non-NixOS hosts"
  homepage "https://github.com/zach-source/nix-fleet"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.2/nixfleet-darwin-arm64.tar.gz"
      sha256 "03e86e7cbf64b130f95930b21167b68e6128306d0fe37c7828189beb79b204f5"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.2/nixfleet-darwin-amd64.tar.gz"
      sha256 "efe99874e1964a5fd0e31c1ca90132c65c85f5003f37e6a2e4938ff5a34ac341"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.2/nixfleet-linux-arm64.tar.gz"
      sha256 "33ad5f546ab4452fd13562944ca885ea61499726e421547831e244681ccd42b4"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.2/nixfleet-linux-amd64.tar.gz"
      sha256 "494b6f9421e55a263a0ee37d8ba2af5d692bfa487a5c27a20b968af489c8ec39"
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
