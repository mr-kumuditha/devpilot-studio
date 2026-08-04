# DevPilot Studio — Troubleshooting Guide

Common issues and resolution steps for **DevPilot Studio**.

---

## 1. Status Bar Not Appearing in Claude Code

- **Cause**: Settings file not wired or terminal session not restarted.
- **Solution**:
  1. Check `~/.claude/settings.json`:
     ```json
     "statusLine": {
       "type": "command",
       "command": "$HOME/.local/bin/devpilot render",
       "padding": 0
     }
     ```
  2. Run `dps install` again to fix settings wiring.
  3. Fully restart your Claude Code terminal session.

---

## 2. Error: `jq: command not found`

- **Cause**: `jq` system utility is missing.
- **Solution**:
  - macOS: `brew install jq`
  - Ubuntu/Debian: `sudo apt-get install jq`

---

## 3. Command `dps: command not found`

- **Cause**: `~/.local/bin` is missing from environment `PATH`.
- **Solution**:
  ```bash
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
  source ~/.zshrc
  ```
