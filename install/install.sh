#!/usr/bin/env bash
set -e

ask() {
  read -rp "$1 [y/N]: " response
  [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
}

echo "Dotfiles installer"
echo "------------------"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ask "Install Neovim config?"; then
  source "$DOTFILES_DIR/install/modules/neovim.sh"
fi

echo "Done."

