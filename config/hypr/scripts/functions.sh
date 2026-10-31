# functions.sh

# init_state — runs once per login (see conf/autostart.conf).
#
# DEFAULT WALLPAPER BEHAVIOUR:
#   Every login starts on themes/wallpapers/default.png, NOT on whatever was used
#   last session. To change the login wallpaper, just overwrite that one file:
#       cp anime_wallpaper2.png default.png
#   (so one duplicate exists, but the original keeps its own name and stays in the cycle).
#   The accent colour is recalculated from default.png on EVERY login, so replacing
#   the image can never leave a stale colour behind.
#   default.* is excluded from the Super+W cycle (see _list_wallpapers) because it is
#   always a copy of a wallpaper that is already in the cycle.
#   hyprpaper.conf points at the same default.png so its first frame matches.
#   Only the exact name default.png is used here - a stray default.jpg etc. is ignored.
#   Fallback: if default.png is missing, the first wallpaper (alphabetical) is used.
init_state() {
    #initialise state files if they don't exist yet
    [ -f "$CURRENT_FILE_WALLPAPER" ] || echo "0" > "$CURRENT_FILE_WALLPAPER"
    [ -f "$CURRENT_FILE_COLOR"     ] || echo "0" > "$CURRENT_FILE_COLOR"

    local login_wp="$WALLPAPER_DIR/default.png"

    if [ ! -f "$login_wp" ]; then
        # No default.png: fall back to the first wallpaper in the cycle
        local wallpapers
        mapfile -t wallpapers < <(_list_wallpapers)
        if [ ${#wallpapers[@]} -eq 0 ]; then
            echo "themectl: no default.png and no wallpapers found in $WALLPAPER_DIR" >&2
            exit 1
        fi
        login_wp="${wallpapers[0]}"
        echo "themectl: default.png not found, falling back to $(basename "$login_wp")" >&2
    fi

    # Only records the choice; update_theme.sh (run by themectl after init) applies it.
    apply_wallpaper "$login_wp"

    # hyprpaper.conf already loads default.png, so re-sending it via hyprctl would only
    # cause a visible reload flicker. Tell hypr/update_theme.sh to skip that step.
    # (Not set in the fallback case: there hyprpaper really needs to be told.)
    if [ "$login_wp" = "$WALLPAPER_DIR/default.png" ]; then
        export THEMECTL_SKIP_WALLPAPER_RELOAD=1
    fi

    # Accent is derived fresh from the wallpaper, same as next_wallpaper does.
    accent_from_wallpaper "$login_wp"
    apply_color "$accent_hex_from_wallpaper"

    echo "themectl: init — wallpaper=$(basename "$login_wp") accent=$accent_hex_from_wallpaper"
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

    accent_from_wallpaper "${wallpapers[$idx]}"
    apply_color "$accent_hex_from_wallpaper"   
    echo "themectl: auto color → $accent_hex_from_wallpaper"
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

    if [ -f "${STATE_DIR}/current_color_hex" ]; then
        local hex
        hex=$(< "${STATE_DIR}/current_color_hex")
        echo "  color: $hex"
    else
        echo "  color: (none)"
    fi
    echo "─────────────────────────────────────────────"
}

#HELPER functions
#list wallpaper files sorted consistently.
#default.* is excluded on purpose: default.png is just a copy of one of the other
#wallpapers (used at login, see init_state), so it would appear twice in the cycle.
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
