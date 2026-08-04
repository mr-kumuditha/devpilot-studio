# DevPilot Studio — Project Instructions

This file contains instructions for Claude Code sessions working on this repository.

## Project Overview

DevPilot Studio (DPS) is a Claude Code Marketplace plugin that provides a real-time
terminal status bar displaying context window usage, 5-hour and 7-day rate limits,
burn-rate velocity alerts, session cost, and 7-day usage sparkline history.

## Architecture

- **`bin/devpilot`** — Core engine (POSIX Bash, ~1100 lines). Handles all rendering,
  stats, history, config wizard, gallery, install/uninstall.
- **`cli.js`** — Node.js entrypoint wrapper for `npx devpilot-studio` installation.
- **`scripts/setup.sh`** — Idempotent plugin setup script (platform detection, jq
  check, binary install, statusLine config).
- **`.claude-plugin/`** — Plugin and marketplace manifests.
- **`hooks/hooks.json`** — Claude Code lifecycle hooks (Setup event).
- **`commands/`** — Slash commands (`setup`, `configure`, `demo`, `uninstall`).

## Key Dependencies

- **`jq`** — Required at runtime for JSON parsing in the bash engine.
- **`bash`** — POSIX-compatible shell (macOS/Linux).
- **`node >= 14`** — Only needed for the `cli.js` npm wrapper.

## Version Management

When bumping versions, update ALL of these files:
1. `bin/devpilot` — `DPS_VERSION="x.y.z"`
2. `package.json` — `"version": "x.y.z"`
3. `.claude-plugin/plugin.json` — `"version": "x.y.z"`
4. `.claude-plugin/marketplace.json` — `plugins[0].version`
5. `scripts/setup.sh` — `DPS_VERSION="x.y.z"`
6. `CHANGELOG.md` — Add new section

## Testing

```bash
# Render status bar from test fixture
cat test/sample-input.json | bin/devpilot render

# Run demo modes
bin/devpilot demo
bin/devpilot demo stats
bin/devpilot demo history

# Test all commands
bin/devpilot version
bin/devpilot help
```

## Code Style

- Bash scripts: 2-space indent, `set -euo pipefail` in scripts, functions prefixed
  with `cmd_` (public) or `_` (internal).
- JSON files: 2-space indent.
- Commit messages: Conventional Commits (`feat:`, `fix:`, `docs:`, `style:`, `chore:`).
