#!/usr/bin/env bash
#
# CreateZenProfileApp.sh
#
# Build a macOS .app bundle that launches Zen Browser with a dedicated
# profile in its own process/window, so it can be pinned to the Dock.
#
# Usage:
#   ./CreateZenProfileApp.sh [profile-name] [icon-path]
#
#   profile-name   Optional. Zen profile to use (created if missing). Default: "Work"
#   icon-path      Optional. Path to a .icns or .png for the Dock icon.
#                  Defaults to Zen's own icon.
#
# Examples:
#   ./CreateZenProfileApp.sh
#   ./CreateZenProfileApp.sh Personal
#   ./CreateZenProfileApp.sh Work ~/Pictures/work-zen.png

set -euo pipefail

PROFILE="${1:-Work}"
ICON_SRC="${2:-}"

ZEN_APP="/Applications/Zen.app"
ZEN_BIN="$ZEN_APP/Contents/MacOS/zen"
APP_NAME="Zen ($PROFILE)"
APP_DIR="/Applications/${APP_NAME}.app"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
die()  { printf '\033[1;31mError:\033[0m %s\n' "$1" >&2; exit 1; }

[ -x "$ZEN_BIN" ] || die "Zen binary not found at $ZEN_BIN. Is Zen installed?"

# --- Ensure the profile exists -------------------------------------------------
PROFILES_INI="$HOME/Library/Application Support/zen/profiles.ini"
if [ -f "$PROFILES_INI" ] && grep -qx "Name=${PROFILE}" "$PROFILES_INI"; then
  info "Using existing Zen profile: $PROFILE"
else
  info "Creating Zen profile: $PROFILE"
  "$ZEN_BIN" -CreateProfile "$PROFILE" >/dev/null 2>&1 || \
    die "Failed to create Zen profile '$PROFILE'"
fi

# --- (Re)build the app bundle --------------------------------------------------
info "Building app bundle: $APP_DIR"
rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"

# Launcher: a tiny native binary that execs Zen with -P to select the profile.
# A native Mach-O (rather than a shell script) is required so LaunchServices
# doesn't wrongly demand Rosetta. -P gives the profile its own process, and
# clicking again focuses the existing window instead of starting a duplicate.
esc() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }
BUILD_TMP="$(mktemp -d)"
cat > "$BUILD_TMP/launcher.c" <<C
#include <unistd.h>
#include <stdlib.h>
int main(int argc, char **argv) {
    const char *zen = "$(esc "$ZEN_BIN")";
    char **a = malloc(sizeof(char *) * (argc + 4));
    int i = 0;
    a[i++] = (char *)zen;
    a[i++] = "-P";
    a[i++] = "$(esc "$PROFILE")";
    for (int j = 1; j < argc; j++) a[i++] = argv[j];
    a[i] = 0;
    execv(zen, a);
    return 1;
}
C
if command -v clang >/dev/null 2>&1; then
  clang -arch "$(uname -m)" -O2 -o "$APP_DIR/Contents/MacOS/launcher" "$BUILD_TMP/launcher.c"
else
  info "clang not found; using a script launcher (may prompt for Rosetta on first run)"
  cat > "$APP_DIR/Contents/MacOS/launcher" <<LAUNCH
#!/bin/bash
exec "$ZEN_BIN" -P "$PROFILE" "\$@"
LAUNCH
  chmod +x "$APP_DIR/Contents/MacOS/launcher"
fi
rm -rf "$BUILD_TMP"

# --- Icon ----------------------------------------------------------------------
ICON_DST="$APP_DIR/Contents/Resources/icon.icns"
make_icns_from_png() {
  local png="$1" out="$2" iconset
  iconset="$(mktemp -d)/icon.iconset"
  mkdir -p "$iconset"
  for sz in 16 32 64 128 256 512; do
    sips -z "$sz" "$sz"        "$png" --out "$iconset/icon_${sz}x${sz}.png"      >/dev/null
    sips -z $((sz*2)) $((sz*2)) "$png" --out "$iconset/icon_${sz}x${sz}@2x.png" >/dev/null
  done
  iconutil -c icns "$iconset" -o "$out"
  rm -rf "$(dirname "$iconset")"
}

# Resolve a python interpreter that has Pillow, bootstrapping a throwaway venv
# into $1 if the system python doesn't already have it. Echoes the path, or
# nothing if Pillow can't be made available.
resolve_python_with_pil() {
  local tmp="$1"
  if python3 -c "import PIL" 2>/dev/null; then echo python3; return; fi
  python3 -m venv "$tmp/venv" >/dev/null 2>&1 || return
  "$tmp/venv/bin/pip" install --quiet Pillow >/dev/null 2>&1 || return
  echo "$tmp/venv/bin/python"
}

# Generate a per-profile, hue-shifted variant of Zen's own icon so each profile
# looks distinct. Falls back (returns non-zero) if Pillow is unavailable.
generate_tinted_icon() {
  local out="$1" tmp; tmp="$(mktemp -d)"
  sips -s format png "$ZEN_APP/Contents/Resources/firefox.icns" --out "$tmp/base.png" >/dev/null 2>&1
  local PY; PY="$(resolve_python_with_pil "$tmp")"
  [ -n "$PY" ] || { rm -rf "$tmp"; return 1; }
  "$PY" - "$tmp/base.png" "$tmp/tinted.png" "$PROFILE" <<'PYEOF' || { rm -rf "$tmp"; return 1; }
import sys, hashlib
from PIL import Image
src, dst, profile = sys.argv[1], sys.argv[2], sys.argv[3]
img = Image.open(src).convert('RGBA')
r, g, b, a = img.split()
h, s, v = Image.merge('RGB', (r, g, b)).convert('HSV').split()
# Deterministic, clearly-visible hue derived from the profile name. Zen's icon
# is near-grayscale, so we also raise saturation to make the tint bold.
hue = int(hashlib.sha1(profile.encode()).hexdigest(), 16) % 256
h = h.point(lambda x: hue)
s = s.point(lambda x: max(x, 170))
r2, g2, b2 = Image.merge('HSV', (h, s, v)).convert('RGB').split()
Image.merge('RGBA', (r2, g2, b2, a)).save(dst)
PYEOF
  make_icns_from_png "$tmp/tinted.png" "$out"
  rm -rf "$tmp"
}

if [ -n "$ICON_SRC" ]; then
  [ -f "$ICON_SRC" ] || die "Icon file not found: $ICON_SRC"
  case "$ICON_SRC" in
    *.icns)        info "Using provided icon"; cp "$ICON_SRC" "$ICON_DST" ;;
    *.png|*.PNG)   info "Converting PNG to .icns"; make_icns_from_png "$ICON_SRC" "$ICON_DST" ;;
    *)             die "Icon must be a .icns or .png file" ;;
  esac
else
  info "No icon given; generating a tinted Zen icon for '$PROFILE'"
  if ! generate_tinted_icon "$ICON_DST"; then
    info "Pillow unavailable; falling back to Zen's default icon"
    cp "$ZEN_APP/Contents/Resources/firefox.icns" "$ICON_DST"
  fi
fi

# --- Info.plist ----------------------------------------------------------------
BUNDLE_ID="org.zen.profile.$(echo "$PROFILE" | tr '[:upper:] ' '[:lower:]-')"
cat > "$APP_DIR/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>            <string>${APP_NAME}</string>
  <key>CFBundleDisplayName</key>     <string>${APP_NAME}</string>
  <key>CFBundleIdentifier</key>      <string>${BUNDLE_ID}</string>
  <key>CFBundleVersion</key>         <string>1.0</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundlePackageType</key>     <string>APPL</string>
  <key>CFBundleExecutable</key>      <string>launcher</string>
  <key>CFBundleIconFile</key>        <string>icon</string>
  <key>NSHighResolutionCapable</key> <true/>
  <key>LSRequiresNativeExecution</key><true/>
</dict>
</plist>
PLIST

# Ad-hoc code-sign so Gatekeeper/LaunchServices launches it cleanly.
codesign --force --sign - "$APP_DIR" >/dev/null 2>&1 || true

# Refresh LaunchServices/Dock icon cache so the new icon shows immediately.
touch "$APP_DIR"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -f "$APP_DIR" >/dev/null 2>&1 || true

info "Done. Created: $APP_DIR"
echo "   Launch it, then right-click its Dock icon → Options → Keep in Dock."
