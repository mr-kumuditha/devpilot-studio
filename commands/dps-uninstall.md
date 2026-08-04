---
description: Uninstall DevPilot Studio — remove status line wiring and optionally delete the binary and config
allowed-tools: Bash(bash:*), Bash(dps:*), Bash(devpilot:*)
---

Uninstall **DevPilot Studio** for the user.

Run the uninstall command. This removes the `statusLine` entry from
`~/.claude/settings.json` (keeping a `.bak` backup), and optionally deletes
the devpilot binary and configuration:

!`"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" uninstall`

After uninstalling, tell the user:

- The status bar will disappear after restarting Claude Code.
- Their settings backup is at `~/.claude/settings.json.bak`.
- Usage history at `~/.local/state/devpilot/history.tsv` is preserved unless they
  explicitly chose to delete it.
- They can reinstall anytime with `/devpilot-studio:setup`.
