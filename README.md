<div align="center">

<img src="assets/dps-logo-horizontal.png" alt="DevPilot Studio Logo" width="680" />

# DevPilot Studio (DPS) 🚀

**A Professional-Grade Claude Code Marketplace Plugin**  
*Real-Time Terminal Status Bar, Usage Analytics, and Rate Limit Monitoring*

<br/>

[![Version](https://img.shields.io/badge/Version-1.1.4-blue.svg?style=for-the-badge&logo=anthropic)](https://github.com/mr-kumuditha/devpilot-studio)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Marketplace%20Plugin-000000?style=for-the-badge&logo=anthropic&logoColor=white)](https://github.com/mr-kumuditha/devpilot-studio)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Security: 100% Offline](https://img.shields.io/badge/Security-100%25%20Offline-success?style=for-the-badge&logo=shield&logoColor=white)](reports/security-audit.md)

[Install Plugin](#-plugin-installation-recommended) • [Features](#-features) • [Commands](#-slash-commands--cli) • [Config](#%EF%B8%8F-configuration--environment) • [FAQ](#-faq)

<br/>

> **DevPilot Studio** is a beautifully designed, highly customizable terminal plugin that gives you complete visibility into your Claude Code AI sessions. Track context window capacity, rate limits, session costs, and velocity alerts — directly in your terminal, with zero external dependencies and 100% offline privacy.

</div>

---

## ⚡ Plugin Installation (Recommended)

Get up and running in 3 simple commands directly inside your Claude Code terminal session:

### 1️⃣ Add the Marketplace
```bash
/plugin marketplace add mr-kumuditha/devpilot-studio
```

### 2️⃣ Install the Plugin
```bash
/plugin install devpilot-studio
```

### 3️⃣ Auto-Configure the Status Bar
```bash
/devpilot-studio:setup
```

> **🎉 That's it!** Exit your current session (`/exit`) and start a new one to see your stunning new status bar at the bottom of the terminal!

---

## ✨ Features

<div align="center">
  <img src="assets/dps-preview.png" alt="DevPilot Studio Status Bar Preview" width="760" />
</div>

<br/>

### 🖥️ **Smart Real-Time Status Bar**
Displays your active AI model, effort level, workspace directory, session cost, and beautifully colored usage progress bars for context window capacity, 5-hour rate limits, and 7-day plan quotas. *(Smart auto-hide: If you use API Keys instead of Claude Pro, irrelevant rate limits automatically vanish to save screen space!)*

### ⚠️ **Velocity Burn-Rate Alerts**
Calculates your token burn rate on the fly. When your session velocity projects hitting quota limits before the reset countdown expires, DevPilot intelligently alerts you with a `⚠` warning.

### 🎨 **Custom Color Themes & Preset Gallery**
Bored of the default colors? Run the interactive wizard to switch between:
- 🌌 **Default**: Subtle, professional dimmed tones.
- 🌑 **Mono**: Clean, minimalist grayscale.
- 🌈 **Vivid**: High-contrast, vibrant cyberpunk colors.
*Customize progress bars using unicode blocks (`█░`), shaded characters (`▓░`), squares (`■□`), or ASCII (`=-`).*

### 📊 **Expanded Usage Panel & 7-Day Analytics**
Need deeper insights? Run `dps stats` for exact token counts (`84k / 200k`), active model details, and reset countdown timers. Run `dps history` to generate gorgeous 8-level terminal sparkline charts (`▃▆▇▄▅▅▅`) tracking your 7-day usage trends.

### 🛡️ **Zero Dependencies & 100% Offline Privacy**
Engineered with absolute privacy. DevPilot Studio operates completely offline. **Zero** telemetry, **zero** analytics tracking, and **zero** npm runtime dependencies. All preferences and history remain securely isolated on your local machine.

---

## 💻 Slash Commands & CLI

DevPilot Studio provides native Claude Code Slash Commands as well as a powerful standalone CLI `dps`.

### 🔌 Plugin Slash Commands (Run inside Claude Code)
| Command | Description |
| :--- | :--- |
| `/devpilot-studio:setup` | Installs and hooks the status bar into your Claude Code settings |
| `/devpilot-studio:configure` | Launches the interactive wizard to customize themes, segments, and bar styles |
| `/devpilot-studio:demo` | Previews the status bar, stats panel, and history chart in your terminal |
| `/devpilot-studio:uninstall` | Safely removes the plugin hooks and restores your old settings |

### 🛠️ CLI Reference (Run in your normal terminal)
| Command | Description | Example Usage |
| :--- | :--- | :--- |
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

## 🔄 Updating

DevPilot Studio supports seamless updates through the Claude Code plugin system:

```bash
/plugin update devpilot-studio
```

Then run `/devpilot-studio:setup` to apply the update. Your personal configuration (`~/.config/devpilot/config`) and history data (`~/.local/state/devpilot/history.tsv`) are always preserved during updates.

---

## 🗑️ Uninstalling

### Via Plugin Command
```bash
/devpilot-studio:uninstall
```

### Via CLI
```bash
dps uninstall
```

This removes the `statusLine` entry from `~/.claude/settings.json` (a `.bak` backup is created). Your usage history and config are preserved unless you explicitly choose to delete them.

---

## ❓ FAQ

**Q: Why doesn't the status bar appear after installation?**  
**A:** You must start a **new** Claude Code session after running `/devpilot-studio:setup`. Just run `/exit` and restart `claude`.

**Q: Where are my 5-hour and 7-day rate limit bars?**  
**A:** DevPilot Studio is smart! If you are authenticated in Claude Code using a direct Anthropic API Key (`sk-ant-api...`), you pay per token and do not have Claude Pro consumer rate limits. DevPilot detects this and cleanly hides those bars. If you switch to an OAuth login, they will automatically appear!

**Q: I get "jq not found" — what do I do?**  
**A:** DevPilot relies on the standard `jq` utility. Install it via your package manager:
- **macOS**: `brew install jq`
- **Ubuntu/Debian**: `sudo apt-get install -y jq`

**Q: Does it work on Windows?**  
**A:** DevPilot Studio requires Bash and works natively on macOS and Linux. On Windows, use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux).

**Q: Does it send my telemetry data anywhere?**  
**A:** Absolutely not. DevPilot Studio is strictly 100% offline. Zero network requests are made. Period.

**Q: Can I use it with other status line tools?**  
**A:** The `statusLine` config supports one command at a time. DevPilot Studio safely replaces any existing status line configuration (a `.bak` backup is always created).

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
> DevPilot Studio is engineered with a strict **privacy-first architecture**. It makes **zero outbound network requests** during status line rendering and contains **zero telemetry or analytics tracking**. 

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
