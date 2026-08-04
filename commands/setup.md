---
description: Install DevPilot Studio and wire it into your Claude Code status line
allowed-tools: Bash(bash:*), Bash(dps:*), Bash(devpilot:*)
---

Set up the **DevPilot Studio** (`dps` / `devpilot`) status line for the user.

Run the plugin setup script. It detects the platform, checks for `jq`, copies the
`devpilot` script to `~/.local/bin/devpilot`, and wires it into
`~/.claude/settings.json` as the status line — merging with any existing settings
and writing a `.bak` backup first:

!bash `"${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"`

Then tell the user:

- Run `/devpilot-studio:configure` or `dps config` in a terminal to customize the look
  (theme, segments, bar style, and optional session-cost / burn-rate display).
- **Start a new Claude Code session** (or restart) for the status line to appear.

Do not modify any files other than what the installer touches.
