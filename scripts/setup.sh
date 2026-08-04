#!/usr/bin/env bash
#
# DevPilot Studio — Automated Plugin Setup Script
# Copyright (c) 2026 Kumuditha Tharinda Liyanage (Kumuditha Labs)
#
# This script is invoked by the Claude Code plugin Setup hook.
# It is idempotent — safe to run on first install, upgrades, and re-runs.
#
# What it does:
#   1. Detects platform (macOS / Linux / WSL)
#   2. Checks for jq dependency
#   3. Copies bin/devpilot to ~/.local/bin/devpilot
#   4. Configures statusLine in ~/.claude/settings.json
#   5. Verifies the installation
#
set -euo pipefail

# --------------------------------------------------------------------------
# Constants
# --------------------------------------------------------------------------
DPS_VERSION="1.2.0"

INSTALL_BIN="$HOME/.local/bin/devpilot"
SETTINGS_DIR="$HOME/.claude"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

# Resolve the plugin root (parent of scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUNDLED_BIN="$PLUGIN_ROOT/bin/devpilot"

# --------------------------------------------------------------------------
# Output helpers
# --------------------------------------------------------------------------
info()  { printf "  ✓ %s\n" "$1" >&2; }
warn()  { printf "  ⚠ %s\n" "$1" >&2; }
err()   { printf "  ✗ %s\n" "$1" >&2; }
header(){ printf "\n  %s\n\n" "$1" >&2; }

# --------------------------------------------------------------------------
# Platform detection
# --------------------------------------------------------------------------
detect_platform() {
  local os
  os="$(uname -s 2>/dev/null || echo unknown)"
  case "$os" in
    Darwin)  PLATFORM="macos" ;;
    Linux)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        PLATFORM="wsl"
      else
        PLATFORM="linux"
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*)
      PLATFORM="windows"
      ;;
    *)
      PLATFORM="unknown"
      ;;
  esac
}

# --------------------------------------------------------------------------
# Dependency check: jq
# --------------------------------------------------------------------------
check_jq() {
  if command -v jq >/dev/null 2>&1; then
    info "jq found at $(command -v jq)"
    return 0
  fi

  warn "jq is not installed — DevPilot Studio requires jq for status bar rendering"

  case "$PLATFORM" in
    macos)
      if command -v brew >/dev/null 2>&1; then
        warn "Install jq with: brew install jq"
      else
        warn "Install Homebrew (https://brew.sh) then run: brew install jq"
      fi
      ;;
    linux|wsl)
      if command -v apt-get >/dev/null 2>&1; then
        warn "Install jq with: sudo apt-get install -y jq"
      elif command -v dnf >/dev/null 2>&1; then
        warn "Install jq with: sudo dnf install -y jq"
      elif command -v pacman >/dev/null 2>&1; then
        warn "Install jq with: sudo pacman -S jq"
      elif command -v apk >/dev/null 2>&1; then
        warn "Install jq with: sudo apk add jq"
      else
        warn "Install jq via your system package manager"
      fi
      ;;
    *)
      warn "Install jq from https://stedolan.github.io/jq/download/"
      ;;
  esac

  return 1
}

# --------------------------------------------------------------------------
# Install binary
# --------------------------------------------------------------------------
install_binary() {
  if [ ! -f "$BUNDLED_BIN" ]; then
    err "bundled devpilot script not found at $BUNDLED_BIN"
    return 1
  fi

  mkdir -p "$(dirname "$INSTALL_BIN")"

  # Compare versions: skip copy if already up-to-date
  if [ -f "$INSTALL_BIN" ]; then
    local installed_ver bundled_ver
    installed_ver=$("$INSTALL_BIN" version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "0.0.0")
    bundled_ver=$(grep -m1 'DPS_VERSION=' "$BUNDLED_BIN" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "0.0.0")

    if [ "$installed_ver" = "$bundled_ver" ]; then
      info "devpilot v$installed_ver already installed at $INSTALL_BIN (up-to-date)"
      return 0
    else
      info "upgrading devpilot $installed_ver → $bundled_ver"
    fi
  fi

  cp "$BUNDLED_BIN" "$INSTALL_BIN"
  chmod +x "$INSTALL_BIN"
  info "installed devpilot v$DPS_VERSION → $INSTALL_BIN"
}

# --------------------------------------------------------------------------
# Configure statusLine in settings.json
# --------------------------------------------------------------------------
configure_statusline() {
  mkdir -p "$SETTINGS_DIR"

  # Create settings.json if it doesn't exist
  if [ ! -f "$SETTINGS_FILE" ]; then
    printf '{}\n' > "$SETTINGS_FILE"
  fi

  # Validate existing JSON
  if ! jq empty "$SETTINGS_FILE" >/dev/null 2>&1; then
    err "$SETTINGS_FILE is not valid JSON — leaving it untouched"
    err "Fix the file manually, then run /devpilot-studio:setup"
    return 1
  fi

  # Check if already configured with devpilot
  local current_cmd
  current_cmd=$(jq -r '.statusLine.command // ""' "$SETTINGS_FILE" 2>/dev/null || echo "")
  if echo "$current_cmd" | grep -q "devpilot render"; then
    info "statusLine already configured for devpilot in $SETTINGS_FILE"
    return 0
  fi

  # Backup existing settings
  cp "$SETTINGS_FILE" "${SETTINGS_FILE}.bak"

  # Merge statusLine config (preserving all other settings)
  local tmp="${SETTINGS_FILE}.dps.tmp"
  if jq --arg cmd "$INSTALL_BIN render" \
        '.statusLine = {type: "command", command: $cmd, padding: 0}' \
        "$SETTINGS_FILE" > "$tmp" 2>/dev/null; then
    mv "$tmp" "$SETTINGS_FILE"
    info "configured statusLine in $SETTINGS_FILE (backup: ${SETTINGS_FILE}.bak)"
  else
    rm -f "$tmp"
    err "failed to update $SETTINGS_FILE — left unchanged"
    return 1
  fi
}

# --------------------------------------------------------------------------
# Verify installation
# --------------------------------------------------------------------------
verify() {
  local ok=true

  if [ ! -x "$INSTALL_BIN" ]; then
    err "devpilot binary not found or not executable at $INSTALL_BIN"
    ok=false
  fi

  if ! jq -e '.statusLine.command' "$SETTINGS_FILE" >/dev/null 2>&1; then
    err "statusLine not configured in $SETTINGS_FILE"
    ok=false
  fi

  if [ "$ok" = true ]; then
    info "installation verified ✓"
  else
    err "installation verification failed — run /devpilot-studio:setup to retry"
    return 1
  fi
}

# --------------------------------------------------------------------------
# Main
# --------------------------------------------------------------------------
main() {
  header "DevPilot Studio v$DPS_VERSION — Plugin Setup"

  detect_platform
  info "platform: $PLATFORM ($(uname -s 2>/dev/null || echo unknown))"

  if [ "$PLATFORM" = "windows" ]; then
    warn "DevPilot Studio requires Bash (macOS/Linux/WSL)"
    warn "On Windows, use WSL: https://learn.microsoft.com/en-us/windows/wsl/install"
    return 1
  fi

  local jq_ok=true
  check_jq || jq_ok=false

  install_binary

  if [ "$jq_ok" = true ]; then
    configure_statusline
    verify
  else
    warn "skipping statusLine config — install jq first, then run /devpilot-studio:setup"
  fi

  printf "\n" >&2
  info "DevPilot Studio setup complete"
  info "Start a new Claude Code session (or restart) to see your status bar"
  printf "\n" >&2
}

main "$@"
