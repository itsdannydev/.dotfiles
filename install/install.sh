#!/usr/bin/env bash
set -e

# colours
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

# flags handling
YES=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        -y|--yes-all)
            YES=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# custom function
ask() {
    local response
    
    # return 0 => yes/true
    # Explanation: exit code 0 => success(true), exit code non zero => failure(false)
    [[ "$YES" == true ]] && return 0
    
    read -rp "$1 [y/N]: " response
    [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
}
center() {
    local text="$1"
    local width
    width=$(tput cols 2>/dev/null || echo 80)

    local padding=$(( (width - ${#text}) / 2 ))
    (( padding < 0 )) && padding=0

    printf "%*s%s\n" "$padding" "" "$text"
}
line() {
    local width
    width=$(tput cols 2>/dev/null || echo 80)

    printf '%*s\n' "$width" '' | tr ' ' '-'
}


# SETUP CODE
# Global directories
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.local/share/dotfiles-backups"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ensure backup dir exists
mkdir -p "$BACKUP_DIR"

# module definiton
modules=(
    "Neovim:neovim.sh"
    "Hyprland:hyprland.sh"
)

echo
line
center "Dotfiles installer"
line
echo 

for entry in "${modules[@]}"; do
    # %% -> remove longest match from end
    # ## -> remove longest match from start
    # % -> remove smallest match from end
    # # -> remove smallest match from start
    name="${entry%%:*}"
    file="${entry##*:}"

    if ask "Install $name config?"; then
        printf "${BLUE}==> $name${RESET}\n"
        source "$DOTFILES_DIR/install/modules/$file"
        echo
    fi
done

line
echo "Selected Configs Installed"

