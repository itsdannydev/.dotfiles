#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ]; then
  echo "Error: DOTFILES_DIR not set. Run via install.sh"
  exit 1
fi


echo "Installing Neovim config..."

NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
SOURCE_DIR="$DOTFILES_DIR/config/nvim"

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

# Backing up if a neovim config already exists
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing config..."
    mkdir -p "$BACKUP_DIR/config"
    TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
    BACKUP_TARGET="$BACKUP_DIR/config/nvim-$TIMESTAMP"
    mkdir -p "$BACKUP_TARGET"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_TARGET"
fi

# Removing symlink if it exists
[ -L "$NVIM_CONFIG_DIR" ] && rm "$NVIM_CONFIG_DIR"

# Creating a new symlink
ln -s "$SOURCE_DIR" "$NVIM_CONFIG_DIR"

echo "Neovim config installed."
