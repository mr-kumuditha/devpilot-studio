# Installation Guide

DevPilot Studio provides several installation methods to accommodate different user workflows.

## Prerequisites

Before installing, ensure your environment meets these requirements:
- **OS**: macOS, Linux, or Windows (via WSL).
- **Tools**: `jq` (required for JSON parsing), `bash`.
- **Node**: Optional, required only for NPX execution.

---

## 1. Claude Code Marketplace (Recommended)

This is the easiest and most seamless installation path.

1. Open your terminal and start Claude Code (`claude`).
2. Add the marketplace:
   ```bash
   /plugin marketplace add mr-kumuditha/devpilot-studio
   ```
3. Install the plugin:
   ```bash
   /plugin install devpilot-studio
   ```
4. Auto-Configure the status line:
   ```bash
   /devpilot-studio:setup
   ```
5. **Restart Claude Code**: Exit the session (`/exit`) and restart `claude`.

---

## 2. NPX Execution

If you prefer using Node package runner (without installing via the Claude Code plugin system):

```bash
npx -y devpilot-studio@latest install
```

This will automatically execute the setup script, copy the binary to your local bin path, and hook it into your `.claude/settings.json`.

---

## 3. Remote Bash Script

For environments without Node or npm, you can use the standalone installer script:

```bash
curl -fsSL https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/install.sh | bash
```

The installer will:
1. Validate `jq` is installed.
2. Download the `devpilot` binary to `~/.local/bin/devpilot`.
3. Add execute permissions.
4. Update `~/.claude/settings.json` with the statusLine hook.

---

## 4. Build from Source

For developers or those who want full control over the installation:

```bash
# 1. Clone the repository
git clone https://github.com/mr-kumuditha/devpilot-studio.git
cd devpilot-studio

# 2. Make the setup script executable
chmod +x scripts/setup.sh

# 3. Run the setup script
./scripts/setup.sh
```

---

## Verifying the Installation

After installing via any of the methods above, verify the installation by running the CLI directly:

```bash
dps version
# Expected Output: DevPilot Studio v1.1.5
```

If `dps` is not found, ensure that `~/.local/bin` is in your system `$PATH`. You can also execute the binary directly:
```bash
~/.local/bin/devpilot version
```

---

## Post-Installation

Once installed, it is highly recommended to configure your DevPilot Studio status bar aesthetics.

Run the interactive wizard in a standard terminal:
```bash
dps config
```

See [CONFIGURATION.md](CONFIGURATION.md) for more details.
