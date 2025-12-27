class Nixfleet < Formula
  desc "Fleet management CLI for deploying Nix configurations to non-NixOS hosts"
  homepage "https://github.com/zach-source/nix-fleet"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.5/nixfleet-darwin-arm64.tar.gz"
      sha256 "ec06100a2391a90dc3f23954612538be21f83c171d9cbaebfd66e13aff040e8e"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.5/nixfleet-darwin-amd64.tar.gz"
      sha256 "565cd04f9c8f29b36f96cfde82606ba129b240c9cde6d756dd55098eb25f7d42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.5/nixfleet-linux-arm64.tar.gz"
      sha256 "9577c7b0032f0ee66ab72a15cc3ed061c0bb248f1ff438f8819969f63532ed6c"
    end

    on_intel do
      url "https://github.com/zach-source/nix-fleet/releases/download/v0.1.5/nixfleet-linux-amd64.tar.gz"
      sha256 "24e1c3f50be0b1452d16aadb14ae816a9b4bbd24d94cd2b72ac0a0323d5c65cb"
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
