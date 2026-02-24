[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

install_link \
    "hypr" \
    "$DOTFILES_DIR/config/hypr" \
    "$CONFIG_DIR/hypr"

echo "Reloading Hyprland config..."

if ! command -v hyprctl >/dev/null; then
    echo "hyprctl not found — skipping reload."
elif hyprctl reload >/dev/null; then
    echo "Hyprland reloaded successfully."
else
    echo "Automatic reload failed — manual reload required."
fi
