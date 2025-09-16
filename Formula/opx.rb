class Opx < Formula
  desc "Multi-backend secret batching daemon with advanced security"
  homepage "https://github.com/zach-source/opx"
  license "MIT"

  on_macos do
    url "https://github.com/zach-source/opx/archive/refs/tags/v0.1.2.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000" # TODO: Update with actual SHA
  end

  depends_on "go" => :build
  depends_on "1password-cli"

  def install
    # Build from source since we need CGO for macOS Security framework
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/opx-authd"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/opx"
    
    # Install binaries
    bin.install "opx-authd"
    bin.install "opx"
    
    # Install documentation
    doc.install "README.md"
    doc.install "CURRENT_STATUS.md" if File.exist?("CURRENT_STATUS.md")
    
    # Install example configuration
    (etc/"opx-authd").mkpath
    (etc/"opx-authd").install "examples/policy.json" => "policy.json.example" if File.exist?("examples/policy.json")
    
    # Create XDG directories
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