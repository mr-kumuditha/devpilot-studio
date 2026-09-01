# Configuration Guide

DevPilot Studio provides an extensive configuration system that relies entirely on simple, file-backed environment variables. 

## Configuration Location

All configurations are stored locally in the following file:
```
${XDG_CONFIG_HOME:-$HOME/.config}/devpilot/config
```

The file consists of standard bash variable exports, making it trivial to source or modify via automated scripts. 
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

Where `<name>` is one of `default`, `mono`, or `vivid`. This updates `DPS_THEME`
in your config file, leaves every other setting (badge, segment visibility, bar
style, width) exactly as it was, prints a one-line confirmation, and shows a
live preview. Invalid names are rejected with the list of valid options.

```bash
dps theme vivid     # switch to the high-contrast palette
dps theme mono      # switch to grayscale
```

Also available through the npm wrapper: `npx devpilot-studio theme vivid`.

Restart Claude Code (or start a new session) for the change to take effect in
the status bar.

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
| `DPS_THEME` | The color palette used for rendering the status bar. Supported values: `default` (dimmed), `mono` (grayscale), `vivid` (bright cyberpunk). | `default` |

### Bar Aesthetics
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_BAR_WIDTH` | Width (in character cells) for all progress bars. | `10` |
| `DPS_BAR_FILLED` | Unicode or ASCII character used to represent the filled portion of a progress bar. | `█` |
| `DPS_BAR_EMPTY` | Unicode or ASCII character used to represent the empty portion of a progress bar. | `░` |

*Examples of popular bar styles:*
- Solid Blocks: `FILLED="█"`, `EMPTY="░"`
- Shaded: `FILLED="▓"`, `EMPTY="░"`
- Squares: `FILLED="■"`, `EMPTY="□"`
- ASCII: `FILLED="="`, `EMPTY="-"`

### Segment Visibility
Visibility flags accept `1` (true/visible) or `0` (false/hidden).

| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_SHOW_EFFORT` | Shows the AI Effort Level segment (e.g., `high`, `normal`). | `1` |
| `DPS_SHOW_CTX` | Shows the Context Window utilization progress bar. | `1` |
| `DPS_SHOW_5H` | Shows the 5-Hour Rate Limit progress bar (only active for Claude Pro). | `1` |
| `DPS_SHOW_7D` | Shows the 7-Day Plan Quota progress bar (only active for Claude Pro). | `1` |
| `DPS_SHOW_COST` | Shows the live session cost (e.g., `$1.42`). | `0` |
| `DPS_SHOW_BURN` | Shows the `⚠` warning when token velocity projects hitting rate limits before they reset. | `1` |

### History & Logging
| Variable | Description | Default |
| :--- | :--- | :--- |
| `DPS_HISTORY` | Enables writing daily rollup statistics to local state (`~/.local/state/devpilot/history.tsv`). Used for the `dps history` sparkline charts. | `1` |

---

## Config File Parsing

The config file is **parsed line by line, never executed**. Only lines of the
exact form `DPS_<KEY>="<value>"` whose `<KEY>` is a recognized `DPS_*` setting
are applied; any other content in the file is ignored. Values are read as
literal strings, so quotes and backslashes in a badge label are safe.
