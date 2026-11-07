#!/bin/bash
# Per-workspace wallpaper hook for rift.
# Invoked by: rift-cli subscribe cli --event workspace_changed
set -uo pipefail

WALLPAPER_DIR="${RIFT_WALLPAPER_DIR:-$HOME/.config/rift/wallpapers}"
DESKTOPPR="${DESKTOPPR:-/usr/local/bin/desktoppr}"
# Only useful if trackpad swipe gestures are enabled (settings.gestures.enabled)
# in config.toml; with plain keybind switching there's no rapid-fire to collapse,
# so default to 0 to avoid adding latency. Override via RIFT_WALLPAPER_DEBOUNCE
# if you turn gestures back on.
DEBOUNCE="${RIFT_WALLPAPER_DEBOUNCE:-0}"

STATE_DIR="${TMPDIR:-/tmp}/rift-wallpaper"
mkdir -p "$STATE_DIR"
APPLIED="$STATE_DIR/applied"
PENDING="$STATE_DIR/pending"

# Find <key>.<ext> in the wallpaper dir
resolve() {
  local key="$1" ext
  [ -n "$key" ] || return 1
  for ext in jpg jpeg png heic tiff; do
    if [ -f "$WALLPAPER_DIR/$key.$ext" ]; then
      printf '%s' "$WALLPAPER_DIR/$key.$ext"; return 0
    fi
  done
  return 1
}

# Prefer name, fall back to index, then to default
target="$(resolve "${RIFT_WORKSPACE_NAME:-}" || resolve "${RIFT_WORKSPACE_ID:-}" || resolve default)"
[ -n "$target" ] && [ -r "$target" ] || exit 0

# Debounce: collapse rapid switches (trackpad swipes) to the final workspace only.
# Skipped entirely when DEBOUNCE is 0 (default) to avoid unnecessary latency.
if [ "$DEBOUNCE" != "0" ]; then
  printf '%s' "$target" > "$PENDING"
  sleep "$DEBOUNCE"
  [ "$(cat "$PENDING" 2>/dev/null)" = "$target" ] || exit 0
fi

# Skip redundant work; macOS also won't redraw an identical path anyway
[ "$(cat "$APPLIED" 2>/dev/null)" = "$target" ] && exit 0

"$DESKTOPPR" "$target" >/dev/null 2>&1 && printf '%s' "$target" > "$APPLIED"
