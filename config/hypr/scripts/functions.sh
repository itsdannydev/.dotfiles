# functions.sh

init_state() {
    #initialise state files if they don't exist yet
    [ -f "$CURRENT_FILE_WALLPAPER" ] || echo "0" > "$CURRENT_FILE_WALLPAPER"
    [ -f "$CURRENT_FILE_COLOR"     ] || echo "0" > "$CURRENT_FILE_COLOR"

    # Collect assets
    local wallpapers colors
    mapfile -t wallpapers < <(_list_wallpapers)
    mapfile -t colors     < <(_list_colors)

    if [ ${#wallpapers[@]} -eq 0 ]; then
        echo "themectl: no wallpapers found in $WALLPAPER_DIR" >&2
        exit 1
    fi

    #read stored data
    local wp_idx color_idx
    wp_idx=$(read_index "$CURRENT_FILE_WALLPAPER")
    color_idx=$(read_index "$CURRENT_FILE_COLOR")

    #normalize the indices and apply wallpaper and color
    wp_idx=$(( wp_idx % ${#wallpapers[@]} ))
    color_idx=$(( ${#colors[@]} > 0 ? color_idx % ${#colors[@]} : 0 ))

    apply_wallpaper "${wallpapers[$wp_idx]}"

    if [ ${#colors[@]} -gt 0 ]; then
        local hex
        hex=$(< "${colors[$color_idx]}")
        apply_color "$hex"
    fi

    #dsplay a status
    echo "themectl: init — wallpaper[${wp_idx}]=$(basename "${wallpapers[$wp_idx]}")"
    [ ${#colors[@]} -gt 0 ] && echo "themectl: init — color[${color_idx}]=$(< "${colors[$color_idx]}")"
}

next_wallpaper() {
    mapfile -t wallpapers < <(_list_wallpapers)

    if [ ${#wallpapers[@]} -eq 0 ]; then
        echo "themectl: no wallpapers found in $WALLPAPER_DIR" >&2
        exit 1
    fi

    local idx
    idx=$(advance_index "$CURRENT_FILE_WALLPAPER" "${#wallpapers[@]}")

    apply_wallpaper "${wallpapers[$idx]}"
    echo "themectl: wallpaper → $(basename "${wallpapers[$idx]}")"
}

next_color() {
    mapfile -t colors < <(_list_colors)

    if [ ${#colors[@]} -eq 0 ]; then
        echo "themectl: no .color files found in $COLORS_DIR" >&2
        exit 1
    fi

    local idx
    idx=$(advance_index "$CURRENT_FILE_COLOR" "${#colors[@]}")

    local hex
    hex=$(< "${colors[$idx]}")
    apply_color "$hex"
    echo "themectl: color → $hex ($(basename "${colors[$idx]}" .color))"
}

print_status() {
    mapfile -t wallpapers < <(_list_wallpapers)
    mapfile -t colors     < <(_list_colors)

    local wp_idx color_idx
    wp_idx=$(read_index "$CURRENT_FILE_WALLPAPER")
    color_idx=$(read_index "$CURRENT_FILE_COLOR")

    echo "── themectl status ──────────────────────────"
    if [ ${#wallpapers[@]} -gt 0 ]; then
        wp_idx=$(( wp_idx % ${#wallpapers[@]} ))
        echo "  wallpaper [${wp_idx}/${#wallpapers[@]}]: $(basename "${wallpapers[$wp_idx]}")"
    else
        echo "  wallpaper: (none)"
    fi

    if [ ${#colors[@]} -gt 0 ]; then
        color_idx=$(( color_idx % ${#colors[@]} ))
        local hex
        hex=$(< "${colors[$color_idx]}")
        echo "  color     [${color_idx}/${#colors[@]}]: $hex  ($(basename "${colors[$color_idx]}" .color))"
    else
        echo "  color: (none)"
    fi
    echo "─────────────────────────────────────────────"
}

#HELPER functions
#list wallpaper files sorted consistently (exclude default.* — it's a fallback)
_list_wallpapers() {
    local f
    shopt -s nullglob
    for f in "$WALLPAPER_DIR"/*.{png,jpg,jpeg,webp}; do
        [[ "$(basename "$f")" == default.* ]] && continue
        echo "$f"
    done | sort
    shopt -u nullglob
}

#list .color files sorted by name
_list_colors() {
    local f
    shopt -s nullglob
    for f in "$COLORS_DIR"/*.color; do
        echo "$f"
    done | sort
    shopt -u nullglob
}
