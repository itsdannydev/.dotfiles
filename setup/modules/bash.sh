[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

install_link \
    ".bashrc" \
    "$DOTFILES_DIR/home/.bashrc" \
    "$HOME/.bashrc"

install_link \
    ".bash_profile" \
    "$DOTFILES_DIR/home/.bash_profile" \
    "$HOME/.bash_profile"
