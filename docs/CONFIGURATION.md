# Configuration Guide

DevPilot Studio provides an extensive configuration system that relies entirely on simple, file-backed environment variables. 

## Configuration Location

All configurations are stored locally in the following file:
```
${XDG_CONFIG_HOME:-$HOME/.config}/devpilot/config
```

The file consists of plain `DPS_KEY="value"` assignments. DevPilot Studio
**parses** this file line by line — it is never sourced or executed (see
[Config File Parsing](#config-file-parsing) below).
*Note: Any changes to this file require restarting Claude Code to take effect.*

---

## Interactive Wizard

The easiest way to configure DevPilot Studio is to use the interactive setup wizard. Since Claude Code's slash commands do not support interactive terminal prompts (TTY), you must run this from a standard terminal session:

```bash
dps config
```

The wizard will guide you through:
- Setting a custom Org/Name badge.
- Toggling the visibility of specific metrics (Cost, Burn Rate, Rate Limits).
- Selecting a global color theme (`default`, `mono`, `vivid`).
- Choosing the progress bar render style (`blocks`, `shaded`, `squares`, `ascii`).

---

## Fast Theme Switch

To change only the color theme without stepping through the full wizard, use:

```bash
dps theme <name>
```

Where `<name>` is one of `default`, `mono`, `vivid`, or `custom`. This updates
`DPS_THEME` in your config file, leaves every other setting (badge, segment
visibility, bar style, width) exactly as it was, prints a one-line confirmation,
and shows a live preview. Invalid names are rejected with the list of valid
options.

```bash
dps theme vivid     # switch to the high-contrast palette
dps theme mono      # switch to grayscale
```

Also available through the npm wrapper: `npx devpilot-studio theme vivid`.

Restart Claude Code (or start a new session) for the change to take effect in
the status bar.

### Named presets

Save the whole current config (theme, colors, layout, segment visibility,
everything) as a reusable preset:

```bash
dps theme save work        # write current config to $CONFIG_DIR/presets/work
dps theme list             # list saved presets
dps theme use work         # load 'work' back into the live config
```

Preset names are restricted to letters, digits, `-`, and `_`. `dps theme use`
loads the preset through the same safe parser as the main config — it is never
sourced.

---

## Environment Variable Reference

If you prefer to configure DevPilot Studio manually or via dotfiles, here is the complete reference of supported variables.

### Identity & Branding
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_ORG` | Custom badge text displayed at the front of the status bar. Leave empty (`""`) to hide the badge. | `""` |

### Theming
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_THEME` | The color palette used for rendering the status bar. `default` (dimmed), `mono` (grayscale), `vivid` (bright), or `custom` (per-role `DPS_COLOR_*`). | `default` |

### Bar Aesthetics
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_BAR_WIDTH` | Width (in character cells) for all progress bars. | `10` |
| `DPS_BAR_FILLED` | Unicode or ASCII character used to represent the filled portion of a progress bar. | `█` |
| `DPS_BAR_EMPTY` | Unicode or ASCII character used to represent the empty portion of a progress bar. | `░` |
| `DPS_THRESHOLD_MID` | Bar fill percent at which the color switches from "low" to "mid". Integer 0–100; must be `< DPS_THRESHOLD_HIGH`. Invalid values fall back to `50`. | `50` |
| `DPS_THRESHOLD_HIGH` | Bar fill percent at which the color switches from "mid" to "high". Integer 0–100. Invalid values fall back to `80`. | `80` |

*Examples of popular bar styles:*
- Solid Blocks: `FILLED="█"`, `EMPTY="░"`
- Shaded: `FILLED="▓"`, `EMPTY="░"`
- Squares: `FILLED="■"`, `EMPTY="□"`
- ASCII: `FILLED="="`, `EMPTY="-"`

### Layout & Icons
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_LAYOUT` | Comma-separated assembly order for the line-2 segments. Valid names: `ctx`, `5h`, `7d`, `over`. Unknown or misspelled names are skipped silently. Each segment keeps its normal rendering (bar, reset countdown, burn suffix). | `ctx,5h,7d,over` |
| `DPS_ICONS` | When `1`, replace the plain-text segment labels (`ctx`, `5h`, `7d`, `over`) with Nerd Font glyphs. Requires a patched font; plain text is the safe default. | `0` |

### Custom Theme Colors
Used only when `DPS_THEME=custom`. Each unset value falls back to the `default`
theme's value, so a partial custom config still renders. Values are raw ANSI
escape sequences (e.g. `\033[1;35m`). If `DPS_TRUECOLOR=1`, a value may instead
be a 6-digit hex color (e.g. `ff8800`), which is converted to a 24-bit ANSI
sequence; a hex value with `DPS_TRUECOLOR=0` falls back to the default color.

| Variable | Role |
| :--- | :--- |
| `DPS_TRUECOLOR` | `1` to accept hex `DPS_COLOR_*` values (24-bit). Default `0`. |
| `DPS_COLOR_MODEL` | Model name |
| `DPS_COLOR_ARROW` | The `->` between model and directory |
| `DPS_COLOR_DIR` | Workspace directory name |
| `DPS_COLOR_ORG` | Org / badge label |
| `DPS_COLOR_BRACKET` | The `[` `]` around the inner group |
| `DPS_COLOR_LABEL` | Segment labels (`ctx`, `5h`, …) and cost |
| `DPS_COLOR_RESETTXT` | Dim "(resets …)" text and the opt-in credit |
| `DPS_COLOR_BAR_LOW` / `_MID` / `_HIGH` | Bar color below MID / between / at or above HIGH threshold |
| `DPS_COLOR_EFFORT_LOW` / `_MED` / `_HIGH` / `_XHIGH` / `_MAX` / `_DEFAULT` | Effort-level word, by level |

### Segment Visibility
Visibility flags accept `1` (true/visible) or `0` (false/hidden).

| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_SHOW_EFFORT` | Shows the AI Effort Level segment (e.g., `high`, `normal`). | `1` |
| `DPS_SHOW_CTX` | Shows the Context Window utilization progress bar. | `1` |
| `DPS_SHOW_5H` | Shows the 5-Hour Rate Limit progress bar (only active for Claude Pro). | `1` |
| `DPS_SHOW_7D` | Shows the 7-Day Plan Quota progress bar (only active for Claude Pro). | `1` |
| `DPS_SHOW_OVERAGE` | Shows the overage bar when the payload reports one. | `0` |
| `DPS_SHOW_COST` | Shows the live session cost (e.g., `$1.42`). | `0` |
| `DPS_SHOW_BURN` | Shows the `⚠` warning when token velocity projects hitting rate limits before they reset. | `1` |
| `DPS_SHOW_CREDIT` | Appends a dim `· tharinda.dev` to the end of line 1 (after the cost segment). Off by default. | `0` |

### History & Logging
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_HISTORY` | Enables writing daily rollup statistics to local state (`~/.local/state/devpilot/history.tsv`). Used for the `dps history` sparkline charts. | `1` |

---

## Terminal-Width Adaptation

When DevPilot Studio renders the real status line and can determine the terminal
width (from `$COLUMNS`, or `tput cols` when a TTY is attached), a narrow terminal
sheds content in this order: **1.** the effort-level segment, **2.** the org
badge, **3.** `DPS_BAR_WIDTH` shrinks (down to 4). When the width cannot be
determined (piped output, no `tput`), nothing is dropped and rendering keeps its
fixed-width behavior.

---

## Config File Parsing

The config file is **parsed line by line, never executed**. Only lines of the
exact form `DPS_<KEY>="<value>"` whose `<KEY>` is a recognized `DPS_*` setting
are applied; any other content in the file is ignored. Values are read as
literal strings, so quotes and backslashes in a badge label are safe.
