class Opx < Formula
  desc "Multi-backend secret batching daemon with advanced security"
  homepage "https://github.com/zach-source/opx"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/opx/releases/download/v0.4.0/opx-server_0.4.0_darwin_arm64_signed.tar.gz"
      sha256 "f38a7e793ec93831910ab1b6fdc8ab39bef0e14d85e9e5c901534cb3f8bf085e"
      
      resource "client" do
        url "https://github.com/zach-source/opx/releases/download/v0.4.0/opx-client_0.4.0_darwin_arm64_signed.tar.gz"
        sha256 "578a6912ba12af29e7513f4aad73246b220674dce0d7f26a5825282e6428b700"
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