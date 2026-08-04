# Development Guide

We welcome contributions! Because DevPilot Studio is written in POSIX Bash, development is fast and requires no compilation step. 

## 1. Local Setup

First, clone the repository and navigate into the directory:

```bash
git clone https://github.com/mr-kumuditha/devpilot-studio.git
cd devpilot-studio
```

## 2. Testing Render Logic

You do not need to install the plugin into Claude Code to test changes to the rendering engine. The repository includes a `test/sample-input.json` file which simulates a payload from Claude Code.

To test rendering changes:
```bash
cat test/sample-input.json | bin/devpilot render
```

This will print the fully formatted ANSI status bar to your terminal.

## 3. Testing CLI Commands

You can run the `demo` commands locally to verify UI changes to the stats panels and sparklines:

```bash
# Test the status bar preview
bin/devpilot demo

# Test the expanded stats panel
bin/devpilot demo stats

# Test the history sparkline generator
bin/devpilot demo history
```

## 4. Testing the Installer

If you are modifying `scripts/setup.sh`, you can test it safely. The script creates a `.bak` backup of `~/.claude/settings.json` before writing any changes.

```bash
./scripts/setup.sh
```

## 5. Code Quality & Linting

DevPilot Studio enforces strict code quality checks via GitHub Actions.

Before submitting a Pull Request, you **must** run `shellcheck` against the bash scripts to ensure there are no POSIX compliance errors, unquoted variables, or syntax issues.

```bash
# Install shellcheck (macOS)
brew install shellcheck

# Run against main scripts
shellcheck -x bin/devpilot
shellcheck -x scripts/setup.sh
```

Additionally, ensure all JSON manifests are structurally valid:
```bash
jq empty .claude-plugin/plugin.json
jq empty hooks/hooks.json
```

## 6. Project Constraints

When developing features for DevPilot Studio, adhere to these constraints:
- **No Dependencies**: Do not introduce dependencies on external tools beyond standard POSIX utilities (`awk`, `sed`, `grep`, `cat`) and `jq`.
- **Performance**: The `devpilot render` function runs continuously during Claude Code sessions. Avoid heavy computations, subshells, or blocking I/O calls. Execution should take less than `50ms`.
- **Privacy**: Do not add outbound network calls (`curl`, `wget`) under any circumstances. DevPilot Studio is 100% offline.
