# Frequently Asked Questions (FAQ)

### Installation & Setup

**Q: Why doesn't the status bar appear after I ran `/devpilot-studio:setup`?**  
**A:** Claude Code needs to reload its settings file to pick up the new `statusLine` command. Simply exit your current session by typing `/exit`, and then restart `claude`.

**Q: I get a "jq not found" error when running DevPilot. What do I do?**  
**A:** DevPilot relies on the standard `jq` utility to parse JSON from Claude Code. Install it via your system's package manager:
- **macOS**: `brew install jq`
- **Ubuntu/Debian**: `sudo apt-get install -y jq`
- **Arch**: `pacman -S jq`

**Q: Does it work on Windows?**  
**A:** DevPilot Studio requires Bash and works natively on macOS and Linux. On Windows, you must run Claude Code inside [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux). Native Command Prompt / PowerShell is not supported.

### Rate Limits & UI

**Q: Where are my 5-hour and 7-day rate limit bars? Why is the UI empty?**  
**A:** DevPilot Studio dynamically adapts to your billing model! If you authenticated in Claude Code using an **Anthropic API Key** (`sk-ant-api...`), you pay per token. Because you pay per token, you are not subject to the Claude Pro consumer rate limits. DevPilot detects this and cleanly hides the 5-hour and 7-day bars to save screen space. If you switch to an OAuth login, the bars will automatically reappear!

**Q: Can I change the colors?**  
**A:** Yes! Run `dps config` in a standard terminal (outside of Claude Code) to launch the interactive wizard. You can select the `vivid` or `mono` themes, and even change the style of the progress bars.

**Q: What does the `⚠` warning mean?**  
**A:** This is the Velocity Burn-Rate Alert. DevPilot calculates the speed at which you are using tokens. If your current pace projects that you will hit 100% capacity before the reset timer expires, the warning appears. You can disable this by setting `DPS_SHOW_BURN=0` or via `dps config`.

### Uninstallation & Compatibility

**Q: How do I completely remove DevPilot Studio?**  
**A:** Run `/devpilot-studio:uninstall` in Claude Code, or `dps uninstall` in a regular terminal. This removes the hooks from `~/.claude/settings.json`. If you want to purge your history and configuration files as well, you can delete `~/.config/devpilot` and `~/.local/state/devpilot`.

**Q: Will this break my other status line tools?**  
**A:** The `statusLine` configuration in Claude Code only supports one active command at a time. Running the setup script will safely overwrite any existing `statusLine` configuration, but it creates a backup of your settings at `~/.claude/settings.json.bak` first.

### Privacy

**Q: Does it send my telemetry or usage data anywhere?**  
**A:** Absolutely not. DevPilot Studio is 100% offline. Zero network requests are made. Period. All data stays strictly local.
