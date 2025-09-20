class Opx < Formula
  desc "Multi-backend secret batching daemon with advanced security"
  homepage "https://github.com/zach-source/opx"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/opx/releases/download/v0.2.0/opx-server_v0.2.0_darwin_arm64.tar.gz"
      sha256 "8c844803e53ce51de02b3848f634707f84fefa40e59e7e7d5afe5c2284b35f75"
      
      resource "client" do
        url "https://github.com/zach-source/opx/releases/download/v0.2.0/opx-client_v0.2.0_darwin_arm64.tar.gz"
        sha256 "9c4c8e9dec498971106d3da186cf3d94e12d162c8ffe477e8b16e0f116eb058f"
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