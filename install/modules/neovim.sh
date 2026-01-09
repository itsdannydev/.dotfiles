#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ]; then
  echo "Error: DOTFILES_DIR not set. Run via install.sh"
  exit 1
fi


echo "Installing Neovim config..."

NVIM_CONFIG_DIR="$HOME/.config/nvim"
SOURCE_DIR="$DOTFILES_DIR/nvim"

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Backing up if a neovim config already exists
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing config..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup.$(date +%s)"
fi

# Removing symlink if it exists
[ -L "$NVIM_CONFIG_DIR" ] && rm "$NVIM_CONFIG_DIR"

# Creating a new symlink
ln -s "$SOURCE_DIR" "$NVIM_CONFIG_DIR"

echo "Neovim config installed."
