# Changelog

All notable changes to DevPilot Studio are documented here. This project adheres to [Semantic Versioning](https://semver.org/).

## [1.5.0] - 2026-09-01

Chat-driven first-run onboarding.

### Added
- **`dps set <KEY> <VALUE>`** — non-interactive setter for a single config key.
  Validates `<KEY>` against the same `DPS_CONFIG_KEYS` allowlist used by the
  safe parser, writes through the same escaped `_write_config` as `dps config`
  and `dps theme` (so every other key keeps its value), and never reads a TTY.
  Unknown keys and missing arguments are rejected with exit code 2.

### Changed
- **`/devpilot-studio:setup` is now chat-driven.** It runs `scripts/setup.sh`
  headlessly, then asks the user for a theme, whether to show session cost, and
  an optional badge label **in the chat**, applies the answers with `dps set`,
  and shows a `dps demo` preview. It no longer points at the TTY-only
  `dps config` wizard, which fails when invoked from a slash command.
- README Quick Start and `docs/INSTALL.md` now describe setup accurately: one
  slash command, a few chat questions, then a restart — not "automatic".

### Notes
- `hooks/hooks.json`'s `Setup` event is a valid Claude Code hook event
  (verified against Claude Code 2.1.252), but it only fires on
  `claude --init` / `--maintenance`, not on `/plugin install`. Manual
  `/devpilot-studio:setup` remains the intended first-run path. The hook is
  left in place (valid, harmless, useful for `--init` users).
- `cmd_config` (the terminal wizard) is unchanged.

## [1.4.0] - 2026-09-01

Theme customization and developer attribution. Every new option is off by
default — an existing config with none of these keys renders exactly as before.

### Added
- **Custom color theme** (`DPS_THEME=custom`): reads per-role colors from
  `DPS_COLOR_MODEL`, `DPS_COLOR_ARROW`, `DPS_COLOR_DIR`, `DPS_COLOR_ORG`,
  `DPS_COLOR_BRACKET`, `DPS_COLOR_LABEL`, `DPS_COLOR_RESETTXT`,
  `DPS_COLOR_BAR_LOW/MID/HIGH`, and
  `DPS_COLOR_EFFORT_LOW/MED/HIGH/XHIGH/MAX/DEFAULT`. Any unset value falls back
  to the `default` theme, so an incomplete custom config still renders.
- **True-color** (`DPS_TRUECOLOR=1`): on the custom theme, `DPS_COLOR_*` may be
  6-digit hex (e.g. `ff8800`), converted to 24-bit ANSI. Built-in themes are
  unchanged.
- **Configurable bar thresholds** (`DPS_THRESHOLD_MID` = 50, `DPS_THRESHOLD_HIGH`
  = 80): the low/mid/high color switch points for every bar. Non-integer,
  out-of-range, or `MID >= HIGH` values fall back to 50 / 80.
- **Configurable segment order** (`DPS_LAYOUT` = `ctx,5h,7d,over`): line 2 is
  assembled by walking this list. Unknown names are skipped silently. The
  default order is byte-for-byte identical to previous output.
- **Terminal-width awareness**: for real status-line rendering, when width is
  known (`$COLUMNS` or `tput cols` with a tty) and the terminal is narrow, the
  effort segment is dropped first, then the org badge, then `DPS_BAR_WIDTH`
  shrinks. When width can't be determined, behavior is unchanged.
- **Named presets**: `dps theme save <name>`, `dps theme use <name>`,
  `dps theme list`. Presets live in `$CONFIG_DIR/presets/`; `<name>` is
  restricted to `[A-Za-z0-9_-]` to prevent path traversal. `use` loads through
  the same safe parser — never sourced.
- **Icon mode** (`DPS_ICONS=1`): swaps the `ctx` / `5h` / `7d` / `over` labels
  for Nerd Font glyphs. Plain text is the default.
- **Developer credit**: `DevPilot Studio — built by tharinda.dev` is printed
  once by `dps version`, `dps help`, `scripts/setup.sh`, `install.sh`, and the
  `npx` installer. It is never printed on the render path.
- **Opt-in status-bar credit** (`DPS_SHOW_CREDIT=1`, default `0`): appends a dim
  `· tharinda.dev` to the end of line 1, after the cost segment. The installers
  mention it; nothing enables it automatically.

### Changed
- `apply_theme`'s `default` palette is factored into `_palette_default` (no
  behavior change) so the custom theme can reuse it as its fallback.
- The config parser and writer are now driven by a single `DPS_CONFIG_KEYS`
  allowlist covering all new keys; assignment still never interprets values as
  code.

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
