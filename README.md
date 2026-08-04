<div align="center">

<img src="assets/dps-logo-horizontal.png" alt="DevPilot Studio Logo" width="680" />

# DevPilot Studio (DPS) 🚀

**A Professional-Grade Claude Code Marketplace Plugin**  
*Real-Time Terminal Status Bar, Usage Analytics, and Rate Limit Monitoring*

<br/>

[![Version](https://img.shields.io/badge/Version-1.1.3-blue.svg?style=for-the-badge&logo=anthropic)](https://github.com/mr-kumuditha/devpilot-studio)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Marketplace%20Plugin-000000?style=for-the-badge&logo=anthropic&logoColor=white)](https://github.com/mr-kumuditha/devpilot-studio)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Security: 100% Offline](https://img.shields.io/badge/Security-100%25%20Offline-success?style=for-the-badge&logo=shield&logoColor=white)](reports/security-audit.md)

[Install Plugin](#-plugin-installation-recommended) • [Features](#-features) • [Commands](#%EF%B8%8F-slash-commands--cli) • [FAQ](#-faq)

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

## ⚙️ Slash Commands & CLI

DevPilot Studio provides native Claude Code Slash Commands as well as a powerful standalone CLI `dps`.

### 🔌 Plugin Slash Commands (Run inside Claude Code)
| Command | Description |
| :--- | :--- |
| `/devpilot-studio:setup` | Installs and hooks the status bar into your Claude Code settings |
| `/devpilot-studio:configure` | Launches the interactive wizard to customize themes, segments, and bar styles |
| `/devpilot-studio:demo` | Previews the status bar, stats panel, and history chart in your terminal |
| `/devpilot-studio:uninstall` | Safely removes the plugin hooks and restores your old settings |

### 💻 CLI Reference (Run in your normal terminal)
| Command | Description |
| :--- | :--- |
| `dps config` | Runs the interactive setup wizard for themes & bar styles |
| `dps stats` | Displays the expanded real-time usage stats panel |
| `dps history` | Displays 7-day usage trends & peak sparkline chart |
| `dps gallery` | Browses and immediately applies preset visual themes |
| `dps render` | (Internal) Reads JSON from stdin and outputs the status line |

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

**Q: Does it send my telemetry data anywhere?**  
**A:** Absolutely not. DevPilot Studio is strictly 100% offline. Zero network requests are made. Period.

---

## 🤝 Contributing & Documentation

Contributions are extremely welcome! DevPilot Studio is built entirely in POSIX bash for ultimate portability and speed.

- 📖 [Installation Guide](docs/INSTALLATION.md)
- ⚙️ [Configuration Guide](docs/CONFIGURATION.md)
- 📐 [Architecture Specification](docs/ARCHITECTURE.md)
- 🛠️ [Developer Guide](docs/DEVELOPER.md)
- 📋 [Changelog](CHANGELOG.md)

---

<div align="center">
  <b>Author & Developer</b>: Kumuditha Tharinda Liyanage<br/>
  <b>Company</b>: Kumuditha Labs<br/>
  <i>Licensed under the MIT License</i><br/><br/>
  <sub>DevPilot Studio is an independent developer utility by Kumuditha Labs. "Claude" and "Claude Code" are trademarks of Anthropic PBC.</sub>
</div>
