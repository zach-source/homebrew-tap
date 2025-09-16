# Homebrew Tap for Utility Tools

A Homebrew tap containing useful utility tools and applications.

## Installation

```bash
# Add the tap
brew tap zach-source/tap

# Install tools
brew install opx
```

## Available Tools

### opx - Multi-Backend Secret Batching Daemon

A secure daemon that provides cached access to secrets from multiple backends (1Password, HashiCorp Vault, OpenBao) with advanced security features.

**Features:**
- Multi-backend secret access (1Password + Vault + Bao)
- Advanced security with process verification and audit logging
- Session management with configurable timeouts
- Policy-based access control with process hierarchy validation
- Interactive management tools

**Installation:**
```bash
brew install opx
```

**Usage:**
```bash
# Start the daemon
brew services start opx

# Or run manually
opx-authd --enable-audit-log --verbose

# Login and read secrets
opx login 1password --account=YOUR_ACCOUNT
opx read "op://vault/item/field"
```

## Adding New Tools

To add a new tool to this tap:

1. Create a new formula in `Formula/<tool-name>.rb`
2. Follow Homebrew formula conventions
3. Test the formula locally
4. Submit a pull request

## Development

```bash
# Test formulas locally
brew install --build-from-source ./Formula/opx.rb

# Audit formula
brew audit --strict ./Formula/opx.rb
```

## Links

- [opx GitHub Repository](https://github.com/zach-source/opx)
- [Homebrew Documentation](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)