class ClaudeMon < Formula
  desc "TUI application for watching Claude Code edits in real-time and managing prompts"
  homepage "https://github.com/zach-source/claude-mon"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zach-source/claude-mon/releases/download/v0.1.0/claude-mon-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/zach-source/claude-mon/releases/download/v0.1.0/claude-mon-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zach-source/claude-mon/releases/download/v0.1.0/claude-mon-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/zach-source/claude-mon/releases/download/v0.1.0/claude-mon-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "claude-mon-darwin-arm64" => "claude-mon" if Hardware::CPU.arm? && OS.mac?
    bin.install "claude-mon-darwin-amd64" => "claude-mon" if Hardware::CPU.intel? && OS.mac?
    bin.install "claude-mon-linux-arm64" => "claude-mon" if Hardware::CPU.arm? && OS.linux?
    bin.install "claude-mon-linux-amd64" => "claude-mon" if Hardware::CPU.intel? && OS.linux?

    # Create symlink for short name
    bin.install_symlink "claude-mon" => "clmon"
  end

  def post_install
    (var/"claude-mon").mkpath
  end

  service do
    run [bin/"claude-mon", "daemon", "start"]
    keep_alive true
    log_path var/"claude-mon/claude-mon.log"
    error_log_path var/"claude-mon/claude-mon-error.log"
    environment_variables(
      CLAUDE_MON_DATA_DIR: var/"claude-mon",
      CLAUDE_MON_DAEMON_SOCKET: "/tmp/claude-mon-daemon.sock",
      CLAUDE_MON_QUERY_SOCKET: "/tmp/claude-mon-query.sock"
    )
  end

  test do
    assert_match "claude-mon", shell_output("#{bin}/claude-mon --help")
    assert_match version.to_s, shell_output("#{bin}/claude-mon --version")
  end
end
