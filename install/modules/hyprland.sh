#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ]; then
    echo "Error: DOTFILES_DIR not set. Run via install.sh"
    exit 1
fi

HYPRLAND_CONFIG_DIR="$CONFIG_DIR/hypr"
SOURCE_DIR="$DOTFILES_DIR/config/hypr"

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

# Backing up if a hyprland config already exists
if [ -e "$HYPRLAND_CONFIG_DIR" ] && [ ! -L "$HYPRLAND_CONFIG_DIR" ]; then
    echo "Backing up existing config..."
    mkdir -p "$BACKUP_DIR/config"
    TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
    BACKUP_TARGET="$BACKUP_DIR/config/hypr-$TIMESTAMP"
    mkdir -p "$BACKUP_TARGET"
    mv "$HYPRLAND_CONFIG_DIR" "$BACKUP_TARGET"
fi

# Removing symlink if it exists
[ -L "$HYPRLAND_CONFIG_DIR" ] && rm "$HYPRLAND_CONFIG_DIR"

# Creating a new symlink
ln -s "$SOURCE_DIR" "$HYPRLAND_CONFIG_DIR"

echo "Hyprland config installed."
echo "Reloading Hyprland config..."

# if command hyprctl does not exist
if ! command -v hyprctl >/dev/null; then
    echo "hyprctl not found — skipping reload."
elif hyprctl reload >/dev/null; then
    echo "Hyprland reloaded successfully."
else
    echo "Automatic reload failed — manual reload required."
fi

