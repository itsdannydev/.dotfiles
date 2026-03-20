DOTFILES_ROOT="$1"
ACCENT_FILE="$DOTFILES_ROOT/themes/accent.color"
# define variable as header
echo "@define-color accent $(< "$ACCENT_FILE" );" > "$DOTFILES_ROOT/config/wofi/style.css"
# cat the styling config
cat "$DOTFILES_ROOT/config/wofi/base.css" >> "$DOTFILES_ROOT/config/wofi/style.css"

# Variables in GTK CSS
#@define-color accent #DC143C;
#window {
#    background-color: @accent;
#    backgroudn: alpha(@accent, 0.5);
#}
