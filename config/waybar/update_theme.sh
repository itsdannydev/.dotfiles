DOTFILES_ROOT="$1"
ACCENT_FILE="$DOTFILES_ROOT/themes/accent.color"
# define variable as header
echo "@define-color accent $(< "$ACCENT_FILE" );" > "$DOTFILES_ROOT/config/waybar/style.css"
# cat the styling config
cat "$DOTFILES_ROOT/config/waybar/base.css" >> "$DOTFILES_ROOT/config/waybar/style.css"

pkill waybar 2>/dev/null || true
sleep 0.5
exec 9>&-
waybar &
disown 

# Variables in GTK CSS
#@define-color accent #DC143C;
#window {
#    background-color: @accent;
#}
