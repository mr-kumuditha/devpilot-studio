<div align="center">

  <div style="display:flex;align-items:center;gap:16px;justify-content:center;padding:12px 0;background:#f6f8fa;border-radius:8px">
    <img src="assets/dps-logo-horizontal.png" alt="DevPilot Studio Logo" width="140" height="36" style="object-fit:contain" />
    <div style="text-align:left">
      <h1 style="margin:0;font-size:20px">DevPilot Studio (DPS)</h1>
      <p style="margin:4px 0 0;font-size:12px;color:#555">
        <strong>A Professional Desktop Utility & CLI Engine for AI Workflows, Session Tracking, MCP Management, and Developer Productivity</strong>
      </p>
    </div>
  </div>

  <p>
    <a href="https://www.npmjs.com/package/devpilot-studio"><img src="https://img.shields.io/npm/v/devpilot-studio?style=for-the-badge&color=007ACC&logo=npm&logoColor=white" alt="NPM Version" /></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License: MIT" /></a>
    <a href="https://nodejs.org"><img src="https://img.shields.io/badge/Node.js-%3E%3D14-brightgreen?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js" /></a>
    <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/Shell-POSIX%20Bash-blue?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash" /></a>
    <a href="reports/security-audit.md"><img src="https://img.shields.io/badge/Security-100%25%20Offline-success?style=for-the-badge&logo=shield&logoColor=white" alt="Security" /></a>
  </p>

  <p>
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-features">Features</a> •
    <a href="#-cli-command-reference">CLI Reference</a> •
    <a href="docs/INSTALLATION.md">Installation</a> •
    <a href="docs/CONFIGURATION.md">Configuration</a> •
    <a href="docs/ARCHITECTURE.md">Architecture</a> •
    <a href="reports/final-summary.md">Reports</a>
  </p>

</div>

---

> [!IMPORTANT]
> **DevPilot Studio** is built from the ground up for developers who demand complete visibility into their AI sessions, rate limits, context windows, and workspace productivity — delivered with [...]

---

## ⚡ Quick Start

Install and wire **DevPilot Studio** into your workflow in seconds:

### Option 1: NPX Installer (Recommended)

```bash
npx devpilot-studio
```

### Option 2: Standalone Curl Installer

```bash
curl -fsSL https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/install.sh | bash
```

### Basic CLI Usage

```bash
# Render status bar from piped input stream
dps render

# Open expanded real-time usage statistics dashboard
dps stats

# View 7-day usage trends & peak sparklines
dps history

# Launch interactive terminal setup wizard
dps config

# Preview preset themes and bar styles
dps gallery
```

---

## ✨ Features

<div align="center">
  <img src="assets/dps-preview.png" alt="DevPilot Studio Status Bar Preview" width="760" />
</div>

### 🖥️ Real-Time Terminal Status Bar
Displays your active AI model, effort level, workspace directory, and live usage progress bars for context window capacity, 5-hour rate limits, and 7-day plan quotas directly inside your terminal sess[...]

### ⚠️ Intelligent Burn-Rate Velocity Alerts
Calculates your current token burn rate and alerts you (`⚠`) when session velocity projects hitting quota limits before reset countdowns expire.

### 📊 Expanded Usage Panel (`dps stats`)
Shows comprehensive session telemetry including exact token counts (`84k / 200k`), active model effort level, reset countdown timers, and live session spending metrics.

### 📈 7-Day Trend Analytics (`dps history`)
Generates 8-level terminal sparkline charts (`▃▆▇▄▅▅▅`) and daily peak rollups without requiring external database servers or background daemons.

### 🎨 Custom Color Themes & Preset Gallery (`dps gallery`)
Includes `default` (subtle dimmed tones), `mono` (clean grayscale), and `vivid` (high-contrast vibrant colors) with customizable unicode blocks (`█░`), shaded characters (`▓░`), or ASCII bars [...]

### 🛡️ Zero Dependencies & 100% Offline Privacy
Operates completely offline with zero telemetry, zero analytics tracking, and zero npm runtime dependencies. All preferences and history remain strictly on your machine.

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

## 📚 Documentation Index

- 📖 [Installation Guide](docs/INSTALLATION.md) — Comprehensive environment setup & PATH configuration.
- ⚙️ [Configuration Guide](docs/CONFIGURATION.md) — Customizing themes, display segments, and bar styles.
- 📐 [Architecture Specification](docs/ARCHITECTURE.md) — Subsystem layout, data pipelines, and extensible router.
- 🛠️ [Developer Guide](docs/DEVELOPER.md) — Building, testing, and contributing to DevPilot Studio.
- 🚀 [Release Guide](docs/RELEASE.md) — Versioning policy and release workflows.
- 🔍 [Troubleshooting Guide](docs/TROUBLESHOOTING.md) — Solutions for common terminal setup questions.
- 📋 [Final Summary Report](reports/final-summary.md) — Exhaustive audit summary & file modification log.
- ⚖️ [Legal Compliance Audit](reports/legacy-references-audit.md) — Verification of MIT legal attributions.

---

## 🔒 Security & Privacy

> [!NOTE]
> DevPilot Studio is engineered with a strict **privacy-first architecture**. It makes **zero outbound network requests** during status line rendering and contains **zero telemetry or analytics t[...]

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
