# Called after any theme change. $ACCENT (hex), $WALLPAPER_PATH available.

# Auto-source config/<tool>/update_theme.sh for every tool dir
for tool_dir in "$DOTFILES_ROOT/config"/*/; do
    tool_update="$tool_dir/update_theme.sh"
    [[ -f "$tool_update" ]] && bash "$tool_update" "$DOTFILES_ROOT" &
done

