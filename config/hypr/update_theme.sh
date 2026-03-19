# config/hypr/update_theme.sh
WALLPAPER=$(< "$DOTFILES_ROOT/config/hypr/.state/current_wallpaper")
DOTFILES_ROOT="$1"
ACCENT=$(< "$DOTFILES_ROOT/themes/accent.color")
WALLPAPER=$(< "$DOTFILES_ROOT/config/hypr/.state/current_wallpaper_name")
WALLPAPER_PATH="$DOTFILES_ROOT/themes/wallpapers/$WALLPAPER"

#update hyprpaper config and reload
# config/hypr/update_theme.sh
# Only runs if hyprctl is available (i.e. Hyprland is running)
command -v hyprctl &>/dev/null || exit

# update border color
hyprctl keyword general:col.active_border "rgba(${ACCENT:1}ee)" 2>/dev/null || true

# update wallpaper
if [[ -f "$WALLPAPER_PATH" ]]; then
    hyprctl hyprpaper unload all 2>/dev/null || true
    hyprctl hyprpaper preload "$WALLPAPER_PATH" 2>/dev/null || true
    while IFS= read -r monitor; do
        [[ -n "$monitor" ]] && hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER_PATH" 2>/dev/null || true
    done < <(hyprctl monitors -j 2>/dev/null | grep -oP '"name":\s*"\K[^"]+')
fi
