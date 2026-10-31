# config/hypr/update_theme.sh
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
# Skipped at login when the wallpaper is default.png: hyprpaper.conf already loaded it
# and reloading would flicker (flag set in init_state, scripts/functions.sh).
if [[ -f "$WALLPAPER_PATH" && -z "$THEMECTL_SKIP_WALLPAPER_RELOAD" ]]; then
    # hyprctl hyprpaper calls are silently dropped if hyprpaper isn't up yet (e.g. the
    # login fallback case), so wait for it (max ~5s) instead of relying on a fixed sleep.
    for _ in {1..25}; do
        hyprctl hyprpaper listloaded &>/dev/null && break
        sleep 0.2
    done
    hyprctl hyprpaper unload all 2>/dev/null || true
    hyprctl hyprpaper preload "$WALLPAPER_PATH" 2>/dev/null || true
    while IFS= read -r monitor; do
        [[ -n "$monitor" ]] && hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER_PATH" 2>/dev/null || true
    done < <(hyprctl monitors -j 2>/dev/null | grep -oP '"name":\s*"\K[^"]+')
fi
