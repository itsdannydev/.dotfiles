# Called after any theme change. $ACCENT (hex), $WALLPAPER_PATH available.

# Auto-source config/<tool>/update_theme.sh for every tool dir
for tool_dir in "$DOTFILES_ROOT/config"/*/; do
    tool_update="$tool_dir/update_theme.sh"
    [[ -f "$tool_update" ]] && bash "$tool_update" "$DOTFILES_ROOT" &
done

# Wait for all tool scripts to finish. At login, waybar is started right after
# "themectl init" and must find the freshly written style.css (not last session's).
wait

