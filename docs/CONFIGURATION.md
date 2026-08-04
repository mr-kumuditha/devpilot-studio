# DevPilot Studio — Configuration Guide

**DevPilot Studio** is fully configurable via an interactive setup wizard, command-line arguments, or direct file editing.

---

## Configuration File Path

Configuration location:
```
${XDG_CONFIG_HOME:-$HOME/.config}/devpilot/config
```

---

## Interactive Wizard (`dps config`)

Run the setup wizard anytime:

```bash
dps config
```

The wizard guides you through selecting:
1. **Org / Badge Label**: Text shown at the start of line 1 (e.g. `[Kumuditha Labs]`). Leave blank to disable.
2. **Segment Visibility**: Toggle Effort level, Context window bar, 5-hour rate limit bar, 7-day rate limit bar, Overage bar, Cost display, and Burn-rate warnings (`⚠`).
3. **Color Themes**: `default` (subtle), `mono` (grayscale), or `vivid` (high-contrast bright colors).
4. **Progress Bar Styles**: Block characters (`█░`), shaded (`▓░`), squares (`■□`), ASCII (`=-`), or custom characters.
5. **Bar Width**: Number of character cells for progress bars (default: `10`).

---

## Environment Variables & Keys

| Key | Description | Default |
| --- | --- | --- |
| `DPS_ORG` | Custom badge text | `""` |
| `DPS_THEME` | Color theme (`default`, `mono`, `vivid`) | `default` |
| `DPS_BAR_WIDTH` | Width in character cells | `10` |
| `DPS_BAR_FILLED` | Filled progress character | `█` |
| `DPS_BAR_EMPTY` | Empty progress character | `░` |
| `DPS_SHOW_EFFORT` | Show effort level (1 or 0) | `1` |
| `DPS_SHOW_CTX` | Show context window bar (1 or 0) | `1` |
| `DPS_SHOW_5H` | Show 5-hour rate limit bar (1 or 0) | `1` |
| `DPS_SHOW_7D` | Show 7-day rate limit bar (1 or 0) | `1` |
| `DPS_SHOW_OVERAGE` | Show extra usage bar (1 or 0) | `0` |
| `DPS_SHOW_COST` | Show session cost (1 or 0) | `0` |
| `DPS_SHOW_BURN` | Show burn-rate velocity warning (1 or 0) | `1` |
| `DPS_HISTORY` | Enable local TSV usage history logging (1 or 0) | `1` |

---

## Preset Gallery (`dps gallery`)

Browse and apply curated themes interactively:

```bash
dps gallery
```
