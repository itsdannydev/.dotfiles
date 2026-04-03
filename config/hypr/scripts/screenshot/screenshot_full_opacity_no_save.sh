# Save current opacity values 
# hyprctl getoption returns a json output. jq .float gives us the value of float key in the json
ACTIVE=$(hyprctl getoption decoration:active_opacity -j | jq .float)
INACTIVE=$(hyprctl getoption decoration:inactive_opacity -j | jq .float)

# Set full opacity
hyprctl keyword decoration:active_opacity 1.0
hyprctl keyword decoration:inactive_opacity 1.0

# Small delay so it visually applies
sleep 0.05

# Take screenshot and copy to clipboard without saving. 
grim -g "$(slurp)" - | wl-copy

# Restore previous opacity
hyprctl keyword decoration:active_opacity $ACTIVE
hyprctl keyword decoration:inactive_opacity $INACTIVE
