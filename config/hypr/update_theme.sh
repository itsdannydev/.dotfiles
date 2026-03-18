#update hyprpaper config and reload
# config/hypr/update_theme.sh
# Only runs if hyprctl is available (i.e. Hyprland is running)
command -v hyprctl &>/dev/null || return 0

if [[ -n "$hex" ]]; then
    hyprctl keyword general:col.active_border "rgba(${hex:1}ee)" 2>/dev/null || true
fi

if [[ -n "$wallpaper_path" ]]; then
    hyprctl hyprpaper unload all 2>/dev/null || true
    hyprctl hyprpaper preload "$wallpaper_path" 2>/dev/null || true
    while IFS= read -r monitor; do
        [[ -n "$monitor" ]] && hyprctl hyprpaper wallpaper "$monitor,$wallpaper_path" 2>/dev/null || true
    done < <(hyprctl monitors -j 2>/dev/null | grep -oP '"name":\s*"\K[^"]+')
fi
