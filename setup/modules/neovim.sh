[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

install_link \
    "nvim" \
    "$DOTFILES_DIR/config/nvim" \
    "$CONFIG_DIR/nvim"
