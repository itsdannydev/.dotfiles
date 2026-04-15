# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

#custom commands
mkcd () {
  local dir="$@"
  mkdir -p -- "$dir" && builtin cd -- "$dir"
}
cd () {
    builtin cd "$@" && tree -L 1
}


export PATH="$HOME/.npm-global/bin:$PATH"

appcat() {
  local file="$1"

  if [[ -z "$file" ]]; then
    echo "Usage: append_and_cat <file_path>"
    return 1
  fi

  if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found"
    return 1
  fi

  echo "$file" >> temp
  cat "$file" >> temp
}

print_dir() {
  local path="$1"

  [[ -z "$path" ]] && { echo "Usage: print_dir <path>"; return 1; }
  [[ ! -e "$path" ]] && { echo "Error: Path '$path' not found"; return 1; }

  if [[ -f "$path" ]]; then
    appcat "$path"
  elif [[ -d "$path" ]]; then
    find "$path" -type f -print0 | while IFS= read -r -d '' file; do
      appcat "$file"
    done
  fi
}

accent() {
    [[ -z "$1" ]] && echo "Usage: accent <image>" && return 1
    magick "$1" \
        -resize 50x50! \
        -colorspace HSL \
        txt:- 2>/dev/null | \
    awk '
        NR > 1 {
            if (match($0, /hsla?\(([0-9.]+),([0-9.]+)%,([0-9.]+)%/, a)) {
                h = a[1]; s = a[2]; l = a[3]
                score = s * (1 - (2*l/100 - 1)^2)
                if (score > best) {
                    best = score
                    bh = h; bs = s; bl = l
                }
            }
        }
        END {
            h = bh/360; s = bs/100; l = bl/100
            if (s > 1) s = 1
            if (l > 1) l = 1
            if (s == 0) { r = g = b = l }
            else {
                q = l < 0.5 ? l*(1+s) : l+s-l*s
                p = 2*l - q
                r = hue2rgb(p, q, h + 1/3)
                g = hue2rgb(p, q, h)
                b = hue2rgb(p, q, h - 1/3)
            }
            r = r < 0 ? 0 : (r > 1 ? 1 : r)
            g = g < 0 ? 0 : (g > 1 ? 1 : g)
            b = b < 0 ? 0 : (b > 1 ? 1 : b)
            printf "Accent: #%02x%02x%02x  hsl(%.0f, %.0f%%, %.0f%%)\n", \
                int(r*255), int(g*255), int(b*255), bh, bs, bl
        }
        function hue2rgb(p, q, t) {
            if (t < 0) t += 1
            if (t > 1) t -= 1
            if (t < 1/6) return p + (q-p)*6*t
            if (t < 1/2) return q
            if (t < 2/3) return p + (q-p)*(2/3-t)*6
            return p
        }
    '
}
