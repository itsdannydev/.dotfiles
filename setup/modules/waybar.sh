[[ -z "$DOTFILES_DIR" ]] && {
    echo "Run via install.sh"
    exit 1
}

install_link \
    "waybar" \
    "$DOTFILES_DIR/config/waybar" \
    "$CONFIG_DIR/waybar"

echo "Starting Waybar config..."

if ! command -v waybar >/dev/null 2>&1; then
    echo "waybar not found — skipped loading waybar."
else
    pkill -q waybar 2>/dev/null || true
    sleep 0.5
    nohup waybar >/dev/null 2>&1 & 
    sleep 1
    if pgrep waybar >/dev/null 2>&1; then
        echo "Waybar loaded successfully."
    else 
        echo "Automatic starting of waybar failed. Run 'waybar &' or restart device for Hyprland to autostart waybar"
    fi
fi
