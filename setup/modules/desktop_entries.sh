[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

shopt -s nullglob

DESKTOP_SRC="$DOTFILES_DIR/desktop-entries/applications"
ICON_SRC="$DOTFILES_DIR/desktop-entries/icons"

DESKTOP_DEST="$HOME/.local/share/applications"
ICON_DEST="$HOME/.local/share/icons/hicolor/128x128/apps"

mkdir -p "$DESKTOP_DEST"
mkdir -p "$ICON_DEST"


echo
echo -e "${GREEN}Linking desktop entries... ${RESET}"

for file in "$DESKTOP_SRC"/*.desktop; do
    [[ -f "$file" ]] || continue # edge case if someone accidentally adds any folder inside the src dir.
    name="$(basename "$file")"
    install_link \
        "$name" \
        "$file" \
        "$DESKTOP_DEST/$name"
    chmod +x "$DESKTOP_DEST/$name" 2>/dev/null || true
done

echo
echo -e "${GREEN}Linking icons... ${RESET}"

for file in "$ICON_SRC"/*; do
    [[ -f "$file" ]] || continue # edge case if someone accidentally adds any folder inside the src dir.
    name="$(basename "$file")"
    install_link \
        "$name" \
        "$file" \
        "$ICON_DEST/$name"
done

shopt -u nullglob

echo
echo "Updating icon cache..."

if command -v gtk-update-icon-cache >/dev/null; then
    gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" || \
        echo "Automatic icon cache updating failed. Run 'gtk-update-icon-cache ~/.local/share/icons/hicolor' manually."
else
    echo "gtk-update-icon-cache not found — skipping."
fi

echo
echo "Updated icon cache."

