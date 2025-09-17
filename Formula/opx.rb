class Opx < Formula
  desc "Multi-backend secret batching daemon with advanced security"
  homepage "https://github.com/zach-source/opx"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/opx/releases/download/v0.1.2/opx-server_v0.1.2_darwin_arm64.tar.gz"
      sha256 "36cdbed53682e8d4713530698053d9c5e5356bc6c456b12051f0530783d85750"
      
      resource "client" do
        url "https://github.com/zach-source/opx/releases/download/v0.1.2/opx-client_v0.1.2_darwin_arm64.tar.gz"
        sha256 "e522c68a2298320ce6bd249a566eda3fdd70475ca0efd3d18f53626e4da6c8b8"
      end
    end
  end

  depends_on "1password"

  def install
    # Install pre-built binaries
    bin.install "opx-authd"
    
    # Install client binary from resource
    resource("client").stage do
      bin.install "opx"
    end
    
    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
    doc.install "LICENSE" if File.exist?("LICENSE")
    
    # Create directories
    (var/"lib/opx-authd").mkpath
    (var/"log/opx-authd").mkpath
  end

  service do
    run [opt_bin/"opx-authd", "--enable-audit-log", "--verbose"]
    keep_alive true
    log_path var/"log/opx-authd/opx-authd.log"
    error_log_path var/"log/opx-authd/opx-authd.error.log"
    environment_variables PATH: std_service_path_env
    working_dir var/"lib/opx-authd"
  end

  test do
    # Test that binaries are installed and functional
    system bin/"opx-authd", "--help"
    system bin/"opx", "--help"
    
    # Test basic functionality
    output = shell_output("#{bin}/opx-authd --help 2>&1")
    assert_match "enable-audit-log", output
    assert_match "session-timeout", output
    assert_match "backend", output
  end
end