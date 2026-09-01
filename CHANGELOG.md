# Changelog

All notable changes to DevPilot Studio are documented here. This project adheres to [Semantic Versioning](https://semver.org/).

## [1.3.0] - 2026-09-01

Bug-fix, cleanup, and security-hardening pass on the Claude Code integration.

### Added
- **`dps theme <name>`**: fast color-theme switch (`default` / `mono` / `vivid`)
  that changes only `DPS_THEME`, preserves every other config key, prints a
  one-line confirmation and a live preview. Also available as
  `npx devpilot-studio theme <name>`.

### Changed
- **Config file is now parsed, not sourced.** `load_config` no longer runs
  `. "$CONFIG_FILE"`. A line parser accepts only `DPS_<KEY>="<value>"` lines
  whose key is in an explicit allowlist; anything else in the file is ignored,
  not executed. On-disk format and location are unchanged.
- **Config writes are escaped.** `dps config` and `dps gallery` now escape
  embedded `"` and `\` in every value (notably the free-text `DPS_ORG` badge)
  before writing, so a quote in a label can no longer break parsing or inject
  shell. `dps config` also now persists `DPS_HISTORY`.
- **Shared statusLine wiring.** `install.sh` and `scripts/setup.sh` now source a
  single helper, `scripts/lib/wire-statusline.sh`, instead of each
  reimplementing the settings.json validate/backup/merge logic. Externally
  visible behavior of both scripts is unchanged.
- Documentation corrected to state that the plugin `Setup` hook only fires on
  `claude --init` / `--maintenance`; the normal install flow is to run
  `/devpilot-studio:setup` once by hand.

### Removed
- Duplicate slash-command files `commands/dps-{configure,demo,setup,uninstall}.md`
  (byte-for-byte copies of the unprefixed versions). CI file list updated.
- Stale "Legacy Fallback Support" section in `docs/CONFIGURATION.md` describing a
  `CCB_*` / `CCBAR_*` fallback that does not exist in the code.

## [1.1.0] - 2026-08-04

Converted DevPilot Studio into a **Claude Code Marketplace plugin** for one-command installation.

### Added
- **Claude Code Plugin Architecture**: Full `.claude-plugin/plugin.json` and `marketplace.json` manifests following the official Claude Code plugin specification.
- **Lifecycle Hooks**: `hooks/hooks.json` with a `Setup` hook that runs `scripts/setup.sh` (fires on `claude --init` / `--maintenance`; the normal flow is to run `/devpilot-studio:setup` once by hand).
- **Idempotent Setup Script** (`scripts/setup.sh`): Platform-aware installer that detects macOS/Linux/WSL, checks for `jq`, installs the devpilot binary, and auto-configures the statusLine — safe for re-runs and upgrades.
- **Slash Commands**:
  - `/devpilot-studio:setup` — Install and wire status bar into Claude Code.
  - `/devpilot-studio:configure` — Launch the interactive theme/segment config wizard.
  - `/devpilot-studio:demo` — Preview status bar, stats panel, and history chart.
  - `/devpilot-studio:uninstall` — Clean removal with backup preservation.
- **GitHub Actions CI/CD**:
  - `ci.yml` — Linting (shellcheck), JSON validation, CLI tests, plugin structure validation, version consistency checks on every push/PR.
  - `release.yml` — Automated GitHub Releases with archive artifacts on version tags.
- **`CLAUDE.md`** — Project instructions for Claude Code sessions.

### Changed
- Bumped version from `1.0.0` → `1.1.0` across all manifests.
- Updated `plugin.json` with complete metadata (commands, hooks paths, keywords, full author object).
- Updated `marketplace.json` with category, tags, and proper source references.
- Rewrote README.md with plugin installation instructions, FAQ, and contributing guide.

## [1.0.0] - 2026-08-04

Initial release of **DevPilot Studio (DPS)** by **Kumuditha Labs (Kumuditha Tharinda Liyanage)**.

### Features
- **Real-Time Status Bar**: Renders active model name, effort level, workspace repository context, and progress bars for context window, 5-hour, and 7-day rate limits.
- **Velocity Warning (`⚠`)**: Real-time velocity warning when usage speed projects hitting quotas before reset countdowns.
- **Detailed Usage Metrics (`dps stats`)**: Terminal usage panel showing token counts, reset countdowns, and session spending.
- **7-Day Sparkline Trends (`dps history`)**: Analytical sparklines and daily peak rollups.
- **Preset Gallery & Setup Wizard (`dps gallery`, `dps config`)**: Themes (`default`, `mono`, `vivid`) and customizable bar styles.
- **Zero Runtime Dependencies**: Ultra-lightweight POSIX Bash and Node.js implementation with 100% offline local privacy.
