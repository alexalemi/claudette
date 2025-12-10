# claudette

Simple bash utilities powered by Claude Haiku.

## c - Natural Language to Bash

Converts natural language to bash commands.

```bash
c list all files larger than 100MB
c find python files modified today
c show disk usage sorted by size
```

The command will be shown on an editable prompt - modify it if needed, then press Enter to execute. The command is saved to your bash history.

## q - Quick Questions

Ask Claude Haiku a quick question from the command line.

```bash
q what is the capital of France
q how do I reverse a string in python
q explain the difference between TCP and UDP
```

## Requirements

- `curl`
- `jq`
- An Anthropic API key

## Installation

Run the install script:

```bash
./install.sh
```

This copies the helper scripts to `~/.local/bin/` and prints the shell functions to add to your `~/.bashrc`:

```bash
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
```

Set your Anthropic API key:

```bash
export ANTHROPIC_API_KEY="your-api-key"
```

Reload your shell:

```bash
source ~/.bashrc
```

## ask-claude

A quick launcher to start a new Claude conversation in your browser with a question.

### Usage

- Run from terminal: `ask-claude "Your question here"`
- Run without arguments to get a GUI prompt
- Use keyboard shortcut (CTRL+ALT+C) for quick access

### Requirements

- `zenity` (for GUI input dialog)
- `xdotool` (for typing automation)
- A web browser

### Installation

1. Copy `ask-claude` to `~/.local/bin/` and make it executable:

```bash
cp ask-claude ~/.local/bin/
chmod +x ~/.local/bin/ask-claude
```

2. (Optional) Install the desktop launcher:

```bash
cp ask-claude.desktop ~/.local/share/applications/
```

3. (Optional) Set up a keyboard shortcut:
   - Open your system's keyboard settings
   - Add a custom shortcut with command: `~/.local/bin/ask-claude`
   - Assign it to CTRL+ALT+C (or your preferred key combination)
