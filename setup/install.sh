#!/usr/bin/env bash
set -euo pipefall

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
    "Neovim:neovim.sh"
    "Hyprland:hyprland.sh"
    "Bash:bash.sh"
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
        source "$DOTFILES_DIR/install/modules/$file"
        echo
    fi
done

line
center "Installation Complete"
line
