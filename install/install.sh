#!/usr/bin/env bash
set -e

ask() {
  read -rp "$1 [y/N]: " response
  [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
}

echo "Dotfiles installer"
echo "------------------"

# Global directories
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.local/share/dotfiles-backups"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$BACKUP_DIR"

if ask "Install Neovim config?"; then
  source "$DOTFILES_DIR/install/modules/neovim.sh"
fi
if ask "Install Hyprland config?"; then
    source "$DOTFILES_DIR/install/modules/hyprland.sh"
fi

echo "Done."

