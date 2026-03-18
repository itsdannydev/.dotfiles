# Called after any theme change. $ACCENT (hex), $WALLPAPER_PATH available.
DOTFILES_ROOT="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.."

# Auto-source config/<tool>/update_theme.sh for every tool dir
for tool_dir in "$DOTFILES_ROOT/config"/*/; do
    tool_update="$tool_dir/update_theme.sh"
    [[ -f "$tool_update" ]] && source "$tool_update"
done
