<div align="center">

  <img src="assets/dps-logo-horizontal.png" alt="DevPilot Studio Logo" width="680" />

  <h1>DevPilot Studio (DPS)</h1>

  <p>
    <strong>A Claude Code Marketplace Plugin — Real-Time Terminal Status Bar for AI Workflows, Rate Limits, and Developer Productivity</strong>
  </p>

  <p>
    <a href="https://www.npmjs.com/package/devpilot-studio"><img src="https://img.shields.io/npm/v/devpilot-studio?style=for-the-badge&color=007ACC&logo=npm&logoColor=white" alt="NPM Version" /></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License: MIT" /></a>
    <a href="https://nodejs.org"><img src="https://img.shields.io/badge/Node.js-%3E%3D14-brightgreen?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js" /></a>
    <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/Shell-POSIX%20Bash-blue?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash" /></a>
    <a href="reports/security-audit.md"><img src="https://img.shields.io/badge/Security-100%25%20Offline-success?style=for-the-badge&logo=shield&logoColor=white" alt="Security" /></a>
  </p>

  <p>
    <a href="#-plugin-installation-recommended">Install Plugin</a> •
    <a href="#-features">Features</a> •
    <a href="#-cli-command-reference">CLI Reference</a> •
    <a href="#%EF%B8%8F-configuration--environment">Configuration</a> •
    <a href="#-faq">FAQ</a> •
    <a href="#-contributing">Contributing</a>
  </p>

</div>

---

> [!IMPORTANT]
> **DevPilot Studio** is a Claude Code Marketplace plugin that gives you complete visibility into your AI sessions — context window capacity, rate limits, burn-rate velocity alerts, and 7-day usage trends — directly in your terminal. Zero runtime dependencies. 100% offline privacy.

---

## ⚡ Plugin Installation (Recommended)

Install DevPilot Studio directly from the Claude Code plugin system in **3 commands**:

### Step 1: Add the marketplace

```
/plugin marketplace add mr-kumuditha/devpilot-studio
```

### Step 2: Install the plugin

```
/plugin install devpilot-studio
```

### Step 3: Set up the status bar

```
/devpilot-studio:setup
```

**Done!** Start a new Claude Code session (or restart) and the status bar appears automatically.

> [!TIP]
> You can also run these from the CLI outside a session:
> ```bash
> claude plugin marketplace add mr-kumuditha/devpilot-studio
> claude plugin install devpilot-studio@devpilot-studio
> ```
> Then run `/devpilot-studio:setup` inside your next session.

---

## 🔧 Alternative Installation Methods

### Option A: NPX Installer

```bash
npx devpilot-studio
```

### Option B: Standalone Curl Installer

```bash
curl -fsSL https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/install.sh | bash
```

---

## ✨ Features

<div align="center">
  <img src="assets/dps-preview.png" alt="DevPilot Studio Status Bar Preview" width="760" />
</div>

### 🖥️ Real-Time Terminal Status Bar
Displays your active AI model, effort level, workspace directory, and colored usage progress bars for context window capacity, 5-hour rate limits, and 7-day plan quotas directly inside your terminal session.

### ⚠️ Intelligent Burn-Rate Velocity Alerts
Calculates your current token burn rate and alerts you (`⚠`) when session velocity projects hitting quota limits before reset countdowns expire.

### 📊 Expanded Usage Panel (`dps stats`)
Shows comprehensive session telemetry including exact token counts (`84k / 200k`), active model effort level, reset countdown timers, and live session spending metrics.

### 📈 7-Day Trend Analytics (`dps history`)
Generates 8-level terminal sparkline charts (`▃▆▇▄▅▅▅`) and daily peak rollups without requiring external database servers or background daemons.

### 🎨 Custom Color Themes & Preset Gallery (`dps gallery`)
Includes `default` (subtle dimmed tones), `mono` (clean grayscale), and `vivid` (high-contrast vibrant colors) with customizable unicode blocks (`█░`), shaded characters (`▓░`), or ASCII bars (`=-`).

### 🛡️ Zero Dependencies & 100% Offline Privacy
Operates completely offline with zero telemetry, zero analytics tracking, and zero npm runtime dependencies. All preferences and history remain strictly on your machine.

### 🔌 Claude Code Plugin Integration
Native Claude Code Marketplace plugin with slash commands, lifecycle hooks, and automatic installation — no manual configuration required.

---

## 🛠️ CLI Command Reference

| Command | Description | Example Usage |
| --- | --- | --- |
| `dps render` | Reads status JSON from stdin and renders formatted status bar | `cat status.json \| dps render` |
| `dps stats` | Displays expanded real-time usage stats panel | `dps stats` |
| `dps history` | Displays 7-day usage trends & peak sparkline chart | `dps history` |
| `dps config` | Runs interactive setup wizard for themes & bar styles | `dps config` |
| `dps gallery` | Browses and applies preset visual themes | `dps gallery` |
| `dps demo` | Previews status bar with sample data | `dps demo` |
| `dps demo stats` | Previews expanded statistics panel with sample data | `dps demo stats` |
| `dps demo history` | Previews 7-day history panel with sample data | `dps demo history` |
| `dps install` | Copies executable to `~/.local/bin` and configures settings | `dps install` |
| `dps uninstall` | Removes status bar configuration from settings | `dps uninstall` |
| `dps version` | Displays version information | `dps version` |
| `dps help` | Shows CLI usage and help text | `dps help` |

### Plugin Slash Commands

| Command | Description |
| --- | --- |
| `/devpilot-studio:setup` | Install and configure the status bar automatically |
| `/devpilot-studio:configure` | Launch the interactive theme/segment config wizard |
| `/devpilot-studio:demo` | Preview status bar, stats panel, and history chart |
| `/devpilot-studio:uninstall` | Clean removal with backup preservation |

---

## 🏗️ Architecture & Technical Blueprint

```
+-------------------------------------------------------------------------+
|                         Claude Code CLI Session                         |
+-------------------------------------------------------------------------+
                                     |
                                     | Status JSON on stdin
                                     v
+-------------------------------------------------------------------------+
|                  DevPilot Studio Engine (bin/devpilot)                  |
|                                                                         |
|  +---------------------+  +--------------------+  +------------------+  |
|  | Config & Theme      |  | Real-Time Status   |  | Stats & History  |  |
|  | Loader              |  | Bar Renderer       |  | Logging Subsystem|  |
|  +---------------------+  +--------------------+  +------------------+  |
+-------------------------------------------------------------------------+
         |                                |                        |
         v                                v                        v
  ~/.config/devpilot             Terminal Output            ~/.local/state/
      /config                  (2-line status bar)             devpilot
                                                             /history.tsv
```

For full architectural documentation, read [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

---

## ⚙️ Configuration & Environment

DevPilot Studio configuration is stored in a clean, hand-editable file at:
```
${XDG_CONFIG_HOME:-$HOME/.config}/devpilot/config
```

### Environment Variables

| Variable | Type | Description | Default |
| --- | --- | --- | --- |
| `DPS_ORG` | String | Custom badge text displayed at front of status bar | `""` |
| `DPS_THEME` | String | Color theme (`default`, `mono`, `vivid`) | `default` |
| `DPS_BAR_WIDTH` | Integer | Progress bar width in character cells | `10` |
| `DPS_BAR_FILLED` | Char | Character used for filled portion of progress bar | `█` |
| `DPS_BAR_EMPTY` | Char | Character used for empty portion of progress bar | `░` |
| `DPS_SHOW_EFFORT` | Boolean | Toggle display of model effort level (`1`/`0`) | `1` |
| `DPS_SHOW_CTX` | Boolean | Toggle display of context window capacity bar (`1`/`0`) | `1` |
| `DPS_SHOW_5H` | Boolean | Toggle display of 5-hour rate limit bar (`1`/`0`) | `1` |
| `DPS_SHOW_7D` | Boolean | Toggle display of 7-day rate limit bar (`1`/`0`) | `1` |
| `DPS_SHOW_COST` | Boolean | Toggle display of session cost (`1`/`0`) | `0` |
| `DPS_SHOW_BURN` | Boolean | Toggle velocity burn-rate warning (`1`/`0`) | `1` |
| `DPS_HISTORY` | Boolean | Toggle local history logging (`1`/`0`) | `1` |

---

## 🔄 Updating

DevPilot Studio supports updates through the Claude Code plugin system:

```
/plugin update devpilot-studio
```

Or manually update by pulling the latest version:

```bash
cd ~/.claude/plugins/devpilot-studio
git pull
```

Then run `/devpilot-studio:setup` to apply the update. Your personal configuration (`~/.config/devpilot/config`) and history data (`~/.local/state/devpilot/history.tsv`) are always preserved during updates.

---

## 🗑️ Uninstalling

### Via Plugin Command

```
/devpilot-studio:uninstall
```

### Via CLI

```bash
dps uninstall
```

This removes the `statusLine` entry from `~/.claude/settings.json` (a `.bak` backup is created). Your usage history and config are preserved unless you explicitly choose to delete them.

---

## ❓ FAQ

**Q: Why does the status bar not appear?**
A: Start a **new** Claude Code session after running `/devpilot-studio:setup`. Older versions of Claude Code may require a full restart.

**Q: I get "jq not found" — what do I do?**
A: Install `jq` via your package manager:
- macOS: `brew install jq`
- Ubuntu/Debian: `sudo apt-get install -y jq`
- Fedora: `sudo dnf install -y jq`

**Q: Does it work on Windows?**
A: DevPilot Studio requires Bash and works on macOS and Linux. On Windows, use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux).

**Q: Does it send data anywhere?**
A: No. DevPilot Studio is 100% offline. Zero telemetry, zero analytics, zero network requests. All data stays on your machine.

**Q: Can I use it with other status line tools?**
A: The `statusLine` config supports one command at a time. DevPilot Studio replaces any existing status line configuration (a `.bak` backup is always created).

---

## 📚 Documentation Index

- 📖 [Installation Guide](docs/INSTALLATION.md) — Comprehensive environment setup & PATH configuration.
- ⚙️ [Configuration Guide](docs/CONFIGURATION.md) — Customizing themes, display segments, and bar styles.
- 📐 [Architecture Specification](docs/ARCHITECTURE.md) — Subsystem layout, data pipelines, and extensible router.
- 🛠️ [Developer Guide](docs/DEVELOPER.md) — Building, testing, and contributing to DevPilot Studio.
- 🚀 [Release Guide](docs/RELEASE.md) — Versioning policy and release workflows.
- 🔍 [Troubleshooting Guide](docs/TROUBLESHOOTING.md) — Solutions for common terminal setup questions.
- 📋 [Changelog](CHANGELOG.md) — Version history and release notes.

---

## 🤝 Contributing

Contributions are welcome! To get started:

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-feature`)
3. Make your changes and test locally:
   ```bash
   cat test/sample-input.json | bin/devpilot render
   bin/devpilot demo
   ```
4. Commit with conventional commit messages (`feat:`, `fix:`, `docs:`)
5. Push and open a Pull Request

See [docs/DEVELOPER.md](docs/DEVELOPER.md) for detailed build and test instructions.

---

## 🔒 Security & Privacy

> [!NOTE]
> DevPilot Studio is engineered with a strict **privacy-first architecture**. It makes **zero outbound network requests** during status line rendering and contains **zero telemetry or analytics tracking**. All history logs and configuration data reside exclusively under your local home directory.

Review the full [Security Audit Report](reports/security-audit.md).

---

## 📄 License & Legal Attribution

- **Author & Developer**: Kumuditha Tharinda Liyanage
- **Company**: Kumuditha Labs
- **Copyright**: © 2026 Kumuditha Tharinda Liyanage
- **License**: MIT License — see [LICENSE](LICENSE) and [NOTICE.md](NOTICE.md) for full legal notices.

<div align="center">
  <sub>DevPilot Studio is an independent developer utility by Kumuditha Labs. "Claude" and "Claude Code" are trademarks of Anthropic PBC.</sub>
</div>
