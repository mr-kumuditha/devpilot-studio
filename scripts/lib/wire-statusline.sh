# shellcheck shell=bash
#
# DevPilot Studio — shared statusLine wiring helper.
#
# Sourced by both scripts/setup.sh and install.sh so the "validate settings.json,
# back it up, merge the statusLine key" logic lives in exactly one place.
#
# Defines one function:
#
#   dps_wire_statusline <settings_file> <status_command> [skip_if_configured]
#
#     Ensures <settings_file> exists (creating "{}" if not), validates it as
#     JSON, backs it up to <settings_file>.bak, and sets:
#
#       .statusLine = { "type": "command", "command": <status_command>, "padding": 0 }
#
#     preserving every other key. Requires `jq` on PATH.
#
#     skip_if_configured=1 makes it a no-op when .statusLine.command already
#     contains "devpilot render".
#
#   Return codes:
#     0  statusLine written (backup path in DPS_WIRE_BACKUP)
#     1  settings file is not valid JSON — left untouched
#     2  jq failed to edit the file — left unchanged
#     3  already wired for devpilot, skipped (only when skip_if_configured=1)
#
#   The function prints nothing; callers report using their own output style.

dps_wire_statusline() {
  local settings_file="$1" status_cmd="$2" skip_if_configured="${3:-0}"
  DPS_WIRE_BACKUP=""

  mkdir -p "$(dirname "$settings_file")"
  [ -f "$settings_file" ] || printf '{}\n' >"$settings_file"

  if ! jq empty "$settings_file" >/dev/null 2>&1; then
    return 1
  fi

  if [ "$skip_if_configured" = "1" ]; then
    local current
    current=$(jq -r '.statusLine.command // ""' "$settings_file" 2>/dev/null || echo "")
    case "$current" in
      *"devpilot render"*) return 3 ;;
    esac
  fi

  cp "$settings_file" "${settings_file}.bak"
  DPS_WIRE_BACKUP="${settings_file}.bak"

  local tmp="${settings_file}.dps.tmp"
  if jq --arg cmd "$status_cmd" \
        '.statusLine = {type: "command", command: $cmd, padding: 0}' \
        "$settings_file" >"$tmp" 2>/dev/null; then
    mv "$tmp" "$settings_file"
    return 0
  fi

  rm -f "$tmp"
  return 2
}
