#!/usr/bin/env bash
set -euo pipefail

# Ralph Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/dominiquegarmier/ralph/main/install.sh | bash

INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/ralph"
REPO="dominiquegarmier/ralph"
BRANCH="main"

echo "Installing ralph..."
echo ""

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"

# Download main script
echo "  Downloading ralph..."
curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/ralph" \
    -o "$INSTALL_DIR/ralph"
chmod +x "$INSTALL_DIR/ralph"

# Download prompt template
echo "  Downloading prompt template..."
curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/prompt.md" \
    -o "$CONFIG_DIR/prompt.md"

# Create default config if not exists
if [[ ! -f "$CONFIG_DIR/config" ]]; then
    echo "  Creating default config..."
    cat > "$CONFIG_DIR/config" << 'EOF'
# Ralph Configuration
# Edit these values to customize behavior

# Maximum iterations per ralph run
MAX_ITERATIONS=10

# Path to prompt template
PROMPT_TEMPLATE="$HOME/.config/ralph/prompt.md"

# Use beads stealth mode (local only, no commits)
BEADS_STEALTH=true
EOF
fi

# Install PRD skill for Claude Code (optional)
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"
if [[ -d "$HOME/.claude" ]]; then
    mkdir -p "$CLAUDE_COMMANDS_DIR"
    echo "  Installing /prd skill for Claude Code..."
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/.claude/commands/prd.md" \
        -o "$CLAUDE_COMMANDS_DIR/prd.md" 2>/dev/null || echo "  (skipped - not found)"
fi

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "⚠ Add ~/.local/bin to your PATH:"
    echo ""
    echo "  # Add to ~/.zshrc or ~/.bashrc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "════════════════════════════════════════════════════════════════"
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "✓ Installed ralph to $INSTALL_DIR/ralph"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Prerequisites (install if missing):"
echo "  brew install jq                    # JSON processor"
echo "  npm i -g @anthropic-ai/claude-code # Claude Code CLI"
echo "  npm i -g @beads/bd                 # Beads task tracker"
echo ""
echo "Quick start:"
echo "  cd your-project"
echo "  ralph --init"
echo "  bd create \"My first task\" -p 0"
echo "  ralph"
echo ""
echo "Or use the /prd skill in Claude Code to generate tasks from an idea."
echo ""
