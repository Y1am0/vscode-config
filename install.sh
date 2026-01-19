#!/usr/bin/env bash

set -e

echo "▶ VS Code Configuration Installer"
echo "---------------------------------"

# Ensure `code` command exists
if ! command -v code >/dev/null 2>&1; then
  echo "❌ 'code' command not found."
  echo "Install it via VS Code:"
  echo "Cmd+Shift+P → Shell Command: Install 'code' command in PATH"
  exit 1
fi

# Detect OS and VS Code user directory
case "$OSTYPE" in
  darwin*)
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    ;;
  linux*)
    VSCODE_USER_DIR="$HOME/.config/Code/User"
    ;;
  msys*|cygwin*)
    VSCODE_USER_DIR="$APPDATA/Code/User"
    ;;
  *)
    echo "❌ Unsupported OS: $OSTYPE"
    exit 1
    ;;
esac

echo "✔ VS Code user directory:"
echo "  $VSCODE_USER_DIR"
echo

# Ensure target directory exists
mkdir -p "$VSCODE_USER_DIR"

# Install extensions
echo "▶ Installing extensions..."
cat extensions.txt | xargs -n 1 code --install-extension
echo "✔ Extensions installed"
echo

# Apply settings
echo "▶ Applying settings.json"
cp .vscode/settings.json "$VSCODE_USER_DIR/settings.json"

echo "▶ Applying keybindings.json"
cp .vscode/keybindings.json "$VSCODE_USER_DIR/keybindings.json"

echo
echo "✅ VS Code configuration applied successfully"
echo "➡ Restart VS Code to finish setup"
