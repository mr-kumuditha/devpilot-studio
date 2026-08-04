# DevPilot Studio — Developer & Contributor Guide

Welcome to the **DevPilot Studio** developer guide. This document explains how to set up your local development environment, test changes, and extend the engine.

---

## Local Repository Setup

1. Fork & clone repository:
   ```bash
   git clone https://github.com/mr-kumuditha/devpilot-studio.git
   cd devpilot-studio
   ```

2. Make executable:
   ```bash
   chmod +x bin/devpilot cli.js install.sh
   ```

3. Run syntax validation:
   ```bash
   bash -n bin/devpilot install.sh
   node --check cli.js
   ```

---

## Local Testing

Test status bar rendering using synthetic JSON streams:

```bash
# Preview status bar
node cli.js demo

# Preview usage statistics dashboard
node cli.js demo stats

# Preview 7-day trend sparklines
node cli.js demo history
```

Test piping direct JSON payload:
```bash
cat test/sample-input.json | ./bin/devpilot render
```

---

## Architecture Guidelines for Future Subsystems

When extending DevPilot Studio with new subcommands (e.g. `dps mcp`, `dps prompts`, `dps git`, `dps models`):
- Maintain zero runtime dependencies.
- Ensure all subprocess calls handle missing terminal conditions gracefully.
- Keep configuration namespace modular using `DPS_*` prefixing.
- Maintain backward-compatibility fallbacks.
