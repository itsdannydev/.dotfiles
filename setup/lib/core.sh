# colours
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

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
install_link() {
    local name="$1"
    local source="$2"
    local target="$3"

    [[ ! -e "$source" ]] && {
        echo "Error: source '$source' not found"
        return 1
    }

    mkdir -p "$(dirname "$target")"

    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "Backing up existing $name..."
        local ts
        ts=$(date +"%Y-%m-%d_%H-%M-%S")
        mv "$target" "$BACKUP_DIR/${name}-${ts}"
    fi

    [[ -L "$target" ]] && rm -f "$target"

    ln -s "$source" "$target"

    echo "$name installed."
}


