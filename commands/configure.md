---
description: Launch the interactive DevPilot Studio configuration wizard to customize themes, segments, and bar styles
allowed-tools: Bash(bash:*), Bash(dps:*), Bash(devpilot:*)
---

Launch the **DevPilot Studio** interactive configuration wizard.

The user can customize:
- **Org badge label** (displayed at the start of the status bar)
- **Segment visibility** (effort level, context window, 5h/7d bars, cost, burn-rate)
- **Color theme** (`default`, `mono`, `vivid`)
- **Bar style** (blocks, shaded, squares, ascii, custom characters)
- **Bar width** (number of character cells)

Run the config wizard:

!`"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" config`

After configuring, tell the user to **start a new Claude Code session** (or restart)
to see the updated status bar.
