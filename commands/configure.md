---
description: Launch the interactive DevPilot Studio configuration wizard to customize themes, segments, and bar styles
---

The **DevPilot Studio configuration wizard** is an interactive terminal program that requires a TTY and direct user input. Because Claude Code's shell execution does not support interactive TTY prompts, you **cannot** execute this tool automatically in the background.

Instead, respond to the user and instruct them to run the following command directly in their terminal prompt:

```bash
dps config
```
*(Alternatively, they can run `devpilot config`)*

Explain to the user that this interactive wizard will let them customize:
- **Org badge label** (displayed at the start of the status bar)
- **Segment visibility** (effort level, context window, 5h/7d bars, cost, burn-rate)
- **Color theme** (`default`, `mono`, `vivid`)
- **Bar style** (blocks, shaded, squares, ascii, custom characters)
- **Bar width** (number of character cells)

Remind them to **start a new Claude Code session** (or restart) after configuring to see the updated status bar.
