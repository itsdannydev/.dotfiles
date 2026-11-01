#!/usr/bin/env bash
set -euo pipefail

# flags handling
YES=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        -y|--yes-all)
            YES=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# SETUP CODE
# Global directories
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.local/share/dotfiles-backups"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$DOTFILES_DIR/setup/lib/core.sh"

# ensure backup dir exists
mkdir -p "$BACKUP_DIR"

# module definiton
modules=(
    "Fonts:fonts.sh"
    "Neovim:neovim.sh"
    "Hyprland:hyprland.sh"
    "Bash:bash.sh"
    "Waybar:waybar.sh"
    "Wofi:wofi.sh"
    "DesktopEntries:desktop_entries.sh"
)

echo
line
center "Dotfiles installer"
line
echo 

for entry in "${modules[@]}"; do
    IFS=":" read -r name file <<< "$entry"

    if ask "Install $name config?"; then
        printf "%b==> %s%b\n" "$BLUE" "$name" "$RESET"
        source "$DOTFILES_DIR/setup/modules/$file"
        echo
    fi
done

# Default wallpaper
# hyprpaper.conf and "themectl init" expect themes/wallpapers/default.png to exist.
# default.png is gitignored (it's the user's own login wallpaper), so a fresh clone
# only has default.placeholder.png - copy it over, but NEVER overwrite an existing
# default.png (this installer is also re-run after every "git pull").
WALLPAPER_DIR="$DOTFILES_DIR/themes/wallpapers"
printf "%b==> %s%b\n" "$BLUE" "Default wallpaper" "$RESET"
echo "Initializing default wallpaper..."
if [[ -f "$WALLPAPER_DIR/default.png" ]]; then
    echo "default.png already exists - leaving it untouched."
elif [[ -f "$WALLPAPER_DIR/default.placeholder.png" ]]; then
    cp "$WALLPAPER_DIR/default.placeholder.png" "$WALLPAPER_DIR/default.png"
    echo "Copied default.placeholder.png -> default.png"
else
    echo "default.placeholder.png not found - skipping."
fi
echo
echo "To use your own wallpapers:"
echo "  1. Put your images in:  $WALLPAPER_DIR/"
echo "     (use Super+W to cycle through them)"
echo "  2. To make one the wallpaper you log in with, overwrite default.png (must be a PNG):"
echo "       cp \"$WALLPAPER_DIR/<your-wallpaper>.png\" \"$WALLPAPER_DIR/default.png\""
echo "     The original keeps its name; default.png is just a copy of it."
echo

line
center "Installation Complete"
line
