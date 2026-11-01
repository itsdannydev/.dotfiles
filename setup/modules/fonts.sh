[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

# Installs the JetBrainsMono Nerd Font (used by waybar, wofi, kitty icons...) into
# ~/.local/share/fonts/nerd, copying the files bundled in assets/fonts/nerd.
#
# Waybar/wofi look the font up BY NAME through fontconfig, so it only has to be
# installed on the system - nothing in the configs points at a file path.
# The bundled files are Nerd Fonts v3.4.0 (identical to the official release),
# so no download is needed and this works offline.

# Only the 4 styles the configs use
FONT_FILES=(
    "JetBrainsMonoNerdFontMono-Regular.ttf"
    "JetBrainsMonoNerdFontMono-Bold.ttf"
    "JetBrainsMonoNerdFontMono-Italic.ttf"
    "JetBrainsMonoNerdFontMono-BoldItalic.ttf"
)

FONT_SRC="$DOTFILES_DIR/assets/fonts/nerd"
FONT_DEST="$HOME/.local/share/fonts/nerd"

fonts_missing=()
for font_file in "${FONT_FILES[@]}"; do
    [[ -f "$FONT_DEST/$font_file" ]] || fonts_missing+=("$font_file")
done

if [[ ${#fonts_missing[@]} -eq 0 ]]; then
    echo "JetBrainsMono Nerd Font already installed - skipping."
else
    mkdir -p "$FONT_DEST"
    fonts_copied=false

    for font_file in "${fonts_missing[@]}"; do
        if [[ -f "$FONT_SRC/$font_file" ]]; then
            cp "$FONT_SRC/$font_file" "$FONT_DEST/"
            fonts_copied=true
        else
            # A broken/partial checkout must not stop the rest of the installer
            echo "Missing bundled font: $FONT_SRC/$font_file"
        fi
    done

    if [[ "$fonts_copied" == true ]]; then
        echo "Fonts installed to $FONT_DEST."
        if command -v fc-cache >/dev/null 2>&1; then
            fc-cache -f "$HOME/.local/share/fonts" && echo "Font cache updated."
        else
            echo "fc-cache not found - log out and in, or run 'fc-cache -f' manually."
        fi
    else
        echo "Could not install the font. Waybar/wofi icons will show as empty boxes"
        echo "until JetBrainsMono Nerd Font is installed."
    fi
fi
