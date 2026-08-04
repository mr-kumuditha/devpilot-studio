#!/usr/bin/env bash
#
# DevPilot Studio (dps / devpilot) installer.
#
#   curl -fsSL https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/install.sh | bash
#
# What it does:
#   1. Checks dependencies (bash, jq, curl).
#   2. Installs `devpilot` to ~/.local/bin/devpilot.
#   3. Wires into ~/.claude/settings.json as the status line (backing up first).
#   4. Runs the interactive setup wizard.
#
# For local testing before publishing, set DPS_SRC to a local copy of bin/devpilot:
#   DPS_SRC=./bin/devpilot bash install.sh
#
set -eu

REPO="mr-kumuditha/devpilot-studio"
REF="${DPS_REF:-main}"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/${REF}"

BIN_DIR="$HOME/.local/bin"
BIN="$BIN_DIR/devpilot"
SETTINGS_DIR="$HOME/.claude"
SETTINGS="$SETTINGS_DIR/settings.json"

# ---- pretty output ----------------------------------------------------------
if [ -t 1 ]; then
  B='\033[1m'; DIM='\033[2m'; GRN='\033[0;32m'; RED='\033[0;31m'; YEL='\033[0;33m'; R='\033[0m'
else
  B=''; DIM=''; GRN=''; RED=''; YEL=''; R=''
fi
say()  { printf "%b\n" "$1"; }
ok()   { printf "%b\n" "${GRN}✓${R} $1"; }
warn() { printf "%b\n" "${YEL}!${R} $1"; }
die()  { printf "%b\n" "${RED}✗${R} $1" >&2; exit 1; }

say "${B}DevPilot Studio Installer${R}"
say ""

# ---- 1. dependencies --------------------------------------------------------
have() { command -v "$1" >/dev/null 2>&1; }

if ! have jq; then
  say "${RED}jq is required but not installed.${R}"
  case "$(uname -s)" in
    Darwin) say "  Install it with:  ${B}brew install jq${R}" ;;
    Linux)
      if have apt-get;   then say "  Install it with:  ${B}sudo apt-get install jq${R}"
      elif have dnf;     then say "  Install it with:  ${B}sudo dnf install jq${R}"
      elif have pacman;  then say "  Install it with:  ${B}sudo pacman -S jq${R}"
      elif have apk;     then say "  Install it with:  ${B}sudo apk add jq${R}"
      else say "  Install jq via your package manager, then re-run this installer."; fi
      ;;
    *) say "  Install jq via your package manager, then re-run this installer." ;;
  esac
  die "missing dependency: jq"
fi

if [ -z "${DPS_SRC:-}" ] && ! have curl; then
  die "curl is required to download devpilot"
fi
ok "dependencies present (jq)"

# ---- 2. install the script --------------------------------------------------
mkdir -p "$BIN_DIR"
if [ -n "${DPS_SRC:-}" ]; then
  cp "$DPS_SRC" "$BIN"
else
  curl -fsSL "$RAW_BASE/bin/devpilot" -o "$BIN" || die "failed to download devpilot from $RAW_BASE/bin/devpilot"
fi
chmod +x "$BIN"
ok "installed ${B}$BIN${R}"

# ---- 3. wire into Claude Code settings --------------------------------------
mkdir -p "$SETTINGS_DIR"
if [ ! -f "$SETTINGS" ]; then
  printf '{}\n' > "$SETTINGS"
fi

if ! jq empty "$SETTINGS" >/dev/null 2>&1; then
  die "$SETTINGS is not valid JSON — leaving it untouched. Fix it and re-run."
fi

cp "$SETTINGS" "${SETTINGS}.bak"
tmp="${SETTINGS}.dps.tmp"
jq --arg cmd "$BIN render" \
   '.statusLine = {type: "command", command: $cmd, padding: 0}' \
   "$SETTINGS" > "$tmp" && mv "$tmp" "$SETTINGS"
ok "configured status line in ${B}$SETTINGS${R} ${DIM}(backup: ${SETTINGS}.bak)${R}"

# ---- 4. run the setup wizard ------------------------------------------------
say ""
if [ -e /dev/tty ]; then
  "$BIN" config || warn "setup wizard skipped — run '${B}dps config${R}' anytime to configure"
else
  warn "no terminal detected — run '${B}dps config${R}' to customize"
fi

# ---- done -------------------------------------------------------------------
say ""
ok "${B}DevPilot Studio installed.${R}"
say ""
say "Preview:"
"$BIN" demo || true
say ""
say "Start a new Claude Code session (or restart) to see your status bar."

case ":$PATH:" in
  *":$BIN_DIR:"*) : ;;
  *) say ""
     say "${DIM}Tip: add ~/.local/bin to your PATH to use 'dps' or 'devpilot' directly:${R}"
     say "${DIM}  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.zshrc${R}" ;;
esac
