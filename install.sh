#!/bin/bash

set -e

INSTALL_DIR="${HOME}/.local/bin"

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Copy helper scripts
cp _c_helper _q_helper "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/_c_helper" "$INSTALL_DIR/_q_helper"

echo "Installed to $INSTALL_DIR"
echo
echo "Add the following to your ~/.bashrc:"
echo
cat <<'EOF'
# Natural language to bash command using Claude
c() {
    local cmd
    cmd=$("$HOME/.local/bin/_c_helper" "$@") || return 1
    read -e -i "$cmd" -p "$ " edited_cmd
    history -s "$edited_cmd"
    eval "$edited_cmd"
}

# Ask a question to Claude Haiku
q() {
    "$HOME/.local/bin/_q_helper" "$@"
}
EOF
echo
echo "Then run: source ~/.bashrc"
echo
echo "Make sure ANTHROPIC_API_KEY is set in your environment."
