# DevPilot Studio — Installation Guide

This guide describes how to install, verify, and wire **DevPilot Studio** (`dps` / `devpilot`) into your environment and Claude Code workflow.

---

## Prerequisites

- **Operating System**: macOS or Linux (WSL supported).
- **Node.js**: `>= 14.0.0` (required for npm package installation & `cli.js` entry point).
- **System Utilities**: `bash` (`>= 3.2`) and `jq`.

### Installing `jq`

DevPilot Studio requires `jq` to parse JSON status streams. Install it via your system package manager:

```bash
# macOS
brew install jq

# Ubuntu / Debian
sudo apt-get install jq

# Fedora / RHEL
sudo dnf install jq

# Arch Linux
sudo pacman -S jq

# Alpine Linux
sudo apk add jq
```

---

## Installation Methods

### Method 1: NPX (Recommended)

Run the interactive installer via `npx`:

```bash
npx devpilot-studio
```

This performs the following actions:
1. Copies `bin/devpilot` to `~/.local/bin/devpilot`.
2. Configures `statusLine` command in `~/.claude/settings.json` (backing up existing settings to `settings.json.bak`).
3. Launches the interactive configuration wizard.

### Method 2: Curl-to-Bash

Run the direct shell installer:

```bash
curl -fsSL https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/install.sh | bash
```

### Method 3: Manual Installation

1. Clone repository:
   ```bash
   git clone https://github.com/mr-kumuditha/devpilot-studio.git
   cd devpilot-studio
   ```
2. Copy binary:
   ```bash
   mkdir -p ~/.local/bin
   cp bin/devpilot ~/.local/bin/devpilot
   chmod +x ~/.local/bin/devpilot
   ```
3. Configure `~/.claude/settings.json`:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "$HOME/.local/bin/devpilot render",
       "padding": 0
     }
   }
   ```

---

## PATH Setup

Ensure `~/.local/bin` is in your environment `PATH`:

```bash
# Zsh (macOS / Linux default)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verify installation:
```bash
dps version
```
