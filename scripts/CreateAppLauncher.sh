#!/usr/bin/env bash
#
# CreateAppLauncher.sh
#
# Build a macOS .app that launches any existing app's binary with extra
# command-line arguments, under a custom name and icon. Useful for pinning a
# specific "mode" of an app: a browser profile, an Electron app with flags,
# a terminal with a startup command, etc.
#
# Usage:
#   ./CreateAppLauncher.sh --target <app-or-binary> --name <name> [options] [-- <args...>]
#
# Required:
#   --target <path>   A .app bundle (e.g. /Applications/Zen.app) or an executable.
#   --name <name>     Name of the launcher app (creates "/Applications/<name>.app").
#
# Options:
#   --icon <file>     .png or .icns to use as the icon. Defaults to the target's icon.
#   --label <text>    Draw this text onto the icon for easy recognition.
#   --random-color    Recolor the icon a random hue (bold, distinct per build).
#   --id <bundle-id>  Override CFBundleIdentifier (default derived from name).
#   --dir <path>      Where to create the .app (default: /Applications).
#   -- <args...>      Everything after -- is passed verbatim to the target binary.
#
# Examples:
#   ./CreateAppLauncher.sh --target /Applications/Zen.app --name "Zen (Work)" \
#       --label Work --random-color -- -P Work
#   ./CreateAppLauncher.sh --target /Applications/Google\ Chrome.app --name "Chrome Dev" \
#       --label Dev -- --profile-directory="Profile 2"
#   ./CreateAppLauncher.sh --target /Applications/Visual\ Studio\ Code.app --name "Code Safe" \
#       -- --disable-extensions

set -euo pipefail

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
die()  { printf '\033[1;31mError:\033[0m %s\n' "$1" >&2; exit 1; }
esc()  { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

# --- Parse arguments -----------------------------------------------------------
TARGET="" NAME="" ICON_SRC="" LABEL="" BUNDLE_ID="" DEST_DIR="/Applications"
RANDOM_COLOR=0
ARGS=()
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET="${2:-}"; shift 2 ;;
    --name)   NAME="${2:-}";   shift 2 ;;
    --icon)   ICON_SRC="${2:-}"; shift 2 ;;
    --label)  LABEL="${2:-}";  shift 2 ;;
    --id)     BUNDLE_ID="${2:-}"; shift 2 ;;
    --dir)    DEST_DIR="${2:-}"; shift 2 ;;
    --random-color) RANDOM_COLOR=1; shift ;;
    --) shift; ARGS=("$@"); break ;;
    -h|--help) sed -n '2,40p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) die "Unknown option: $1 (use --help)" ;;
  esac
done

[ -n "$TARGET" ] || die "--target is required"
[ -n "$NAME" ]   || die "--name is required"

# --- Resolve the target binary + its app bundle (for the default icon) ---------
APP_SRC=""
if [ -d "$TARGET" ] && [ -f "$TARGET/Contents/Info.plist" ]; then
  APP_SRC="$TARGET"
  EXE="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$TARGET/Contents/Info.plist" 2>/dev/null)" \
    || die "Could not read CFBundleExecutable from $TARGET"
  TARGET_BIN="$TARGET/Contents/MacOS/$EXE"
else
  TARGET_BIN="$TARGET"
fi
[ -x "$TARGET_BIN" ] || die "Target binary not found/executable: $TARGET_BIN"

APP_DIR="$DEST_DIR/${NAME}.app"
[ -n "$BUNDLE_ID" ] || BUNDLE_ID="org.launcher.$(echo "$NAME" | tr '[:upper:] ' '[:lower:]-' | tr -cd 'a-z0-9.-')"

# --- Build the bundle skeleton -------------------------------------------------
info "Building launcher: $APP_DIR"
rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"

# --- Native launcher: execs the target binary with the fixed args, then any
#     args the OS passes (e.g. opened files/URLs). A compiled Mach-O (not a
#     shell script) is required so LaunchServices doesn't demand Rosetta.
FIXED_INIT=""
for a in ${ARGS+"${ARGS[@]}"}; do FIXED_INIT+="\"$(esc "$a")\", "; done
NF=${#ARGS[@]}
BUILD_TMP="$(mktemp -d)"
cat > "$BUILD_TMP/launcher.c" <<C
#include <unistd.h>
#include <stdlib.h>
int main(int argc, char **argv) {
    const char *bin = "$(esc "$TARGET_BIN")";
    char *fixed[] = { ${FIXED_INIT}0 };
    int nf = $NF;
    char **a = malloc(sizeof(char *) * (nf + argc + 2));
    int i = 0;
    a[i++] = (char *)bin;
    for (int k = 0; k < nf; k++) a[i++] = fixed[k];
    for (int j = 1; j < argc; j++) a[i++] = argv[j];
    a[i] = 0;
    execv(bin, a);
    return 1;
}
C
if command -v clang >/dev/null 2>&1; then
  clang -arch "$(uname -m)" -O2 -o "$APP_DIR/Contents/MacOS/launcher" "$BUILD_TMP/launcher.c" \
    || die "Failed to compile launcher"
else
  info "clang not found; using a script launcher (may prompt for Rosetta on first run)"
  {
    printf '#!/bin/bash\nexec "%s"' "$TARGET_BIN"
    for a in ${ARGS+"${ARGS[@]}"}; do printf ' "%s"' "$a"; done
    printf ' "$@"\n'
  } > "$APP_DIR/Contents/MacOS/launcher"
  chmod +x "$APP_DIR/Contents/MacOS/launcher"
fi
rm -rf "$BUILD_TMP"

# --- Icon helpers --------------------------------------------------------------
make_icns_from_png() {
  local png="$1" out="$2" iconset
  iconset="$(mktemp -d)/icon.iconset"; mkdir -p "$iconset"
  for sz in 16 32 64 128 256 512; do
    sips -z "$sz" "$sz"           "$png" --out "$iconset/icon_${sz}x${sz}.png"    >/dev/null
    sips -z $((sz*2)) $((sz*2))   "$png" --out "$iconset/icon_${sz}x${sz}@2x.png" >/dev/null
  done
  iconutil -c icns "$iconset" -o "$out"
  rm -rf "$(dirname "$iconset")"
}

resolve_python_with_pil() {
  local tmp="$1"
  if python3 -c "import PIL" 2>/dev/null; then echo python3; return; fi
  python3 -m venv "$tmp/venv" >/dev/null 2>&1 || return
  "$tmp/venv/bin/pip" install --quiet Pillow >/dev/null 2>&1 || return
  echo "$tmp/venv/bin/python"
}

# Locate the target app's .icns (CFBundleIconFile, falling back to any .icns).
target_icns() {
  [ -n "$APP_SRC" ] || return 1
  local name
  name="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIconFile' "$APP_SRC/Contents/Info.plist" 2>/dev/null)"
  name="${name%.icns}.icns"
  if [ -f "$APP_SRC/Contents/Resources/$name" ]; then
    echo "$APP_SRC/Contents/Resources/$name"
  else
    ls "$APP_SRC/Contents/Resources/"*.icns 2>/dev/null | head -1
  fi
}

# --- Build the icon ------------------------------------------------------------
ICON_DST="$APP_DIR/Contents/Resources/icon.icns"
NEED_PROCESS=0
{ [ -n "$LABEL" ] || [ "$RANDOM_COLOR" = 1 ]; } && NEED_PROCESS=1

# Resolve a base PNG to work from (only needed when processing).
base_png() {
  local out="$1" tmp; tmp="$(dirname "$out")"
  case "$ICON_SRC" in
    *.png|*.PNG) cp "$ICON_SRC" "$out" ;;
    *.icns)      sips -s format png "$ICON_SRC" --out "$out" >/dev/null 2>&1 ;;
    "")          local ic; ic="$(target_icns)" || return 1
                 sips -s format png "$ic" --out "$out" >/dev/null 2>&1 ;;
    *)           return 1 ;;
  esac
}

if [ "$NEED_PROCESS" = 0 ]; then
  # No processing: use the provided icon, or copy the target app's icon.
  case "$ICON_SRC" in
    *.icns)      info "Using provided icon"; cp "$ICON_SRC" "$ICON_DST" ;;
    *.png|*.PNG) info "Converting PNG to .icns"; make_icns_from_png "$ICON_SRC" "$ICON_DST" ;;
    "")          info "Using target app's icon"
                 ic="$(target_icns)" && cp "$ic" "$ICON_DST" || info "No icon found; app will use a default" ;;
    *)           die "Icon must be a .icns or .png file" ;;
  esac
else
  info "Generating custom icon (label='${LABEL}', random-color=$RANDOM_COLOR)"
  tmp="$(mktemp -d)"
  if base_png "$tmp/base.png" && PY="$(resolve_python_with_pil "$tmp")" && [ -n "$PY" ]; then
    "$PY" - "$tmp/base.png" "$tmp/out.png" "$LABEL" "$RANDOM_COLOR" <<'PYEOF'
import sys, random
from PIL import Image, ImageDraw, ImageFont
src, dst, label, recolor = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4] == "1"
img = Image.open(src).convert('RGBA')
if recolor:
    r, g, b, a = img.split()
    h, s, v = Image.merge('RGB', (r, g, b)).convert('HSV').split()
    hue = random.randint(0, 255)
    h = h.point(lambda x: hue)
    s = s.point(lambda x: max(x, 170))
    r2, g2, b2 = Image.merge('HSV', (h, s, v)).convert('RGB').split()
    img = Image.merge('RGBA', (r2, g2, b2, a))
if label:
    W, H = img.size
    draw = ImageDraw.Draw(img)
    def load_font(size):
        for p in ("/System/Library/Fonts/HelveticaNeue.ttc",
                  "/System/Library/Fonts/Helvetica.ttc",
                  "/Library/Fonts/Arial.ttf"):
            try:
                return ImageFont.truetype(p, size)
            except Exception:
                pass
        return ImageFont.load_default()
    size = int(H * 0.22)
    while size > 12:
        font = load_font(size)
        if draw.textlength(label, font=font) <= W * 0.86:
            break
        size -= 8
    w = draw.textlength(label, font=font)
    draw.text(((W - w) / 2, H * 0.64), label, font=font, fill=(255, 255, 255, 255),
              stroke_width=max(2, size // 12), stroke_fill=(0, 0, 0, 255))
img.save(dst)
PYEOF
    make_icns_from_png "$tmp/out.png" "$ICON_DST"
  else
    info "Pillow/base icon unavailable; falling back to target app's icon"
    ic="$(target_icns)" && cp "$ic" "$ICON_DST" || true
  fi
  rm -rf "$tmp"
fi

# --- Info.plist + sign + register ----------------------------------------------
cat > "$APP_DIR/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>            <string>${NAME}</string>
  <key>CFBundleDisplayName</key>     <string>${NAME}</string>
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

codesign --force --sign - "$APP_DIR" >/dev/null 2>&1 || true
touch "$APP_DIR"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -f "$APP_DIR" >/dev/null 2>&1 || true

info "Done. Created: $APP_DIR"
echo "   Open it from Finder or Spotlight."
