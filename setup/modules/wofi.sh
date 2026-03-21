[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

install_link \
    "wofi" \
    "$DOTFILES_DIR/config/wofi" \
    "$CONFIG_DIR/wofi"
