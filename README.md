![Dotfiles banner](assets/banner.png)

# Dotfiles
> Not perfect. Just mine.

This repository contains my personal **dotfiles** — configuration files that define how my development environment behaves.

Dotfiles are used to customize tools, workflows, and editor behavior in a way that is:

- reproducible
- version-controlled
- portable across machines

The goal of this repo is not to be a “one-size-fits-all” setup, but a **personal, evolving configuration** that reflects how I work.

> Note: This setup is currently tested only on Linux (Fedora + Hyprland). Other platforms may require adjustments.

## What’s inside (currently)

- **Hyprland configuration**
  - Uses hyprpaper as wallpaper manager
  - Make sure to adjust default apps like terminal and menu in the config.
- **Neovim configuration**
  - Modular Lua-based setup
  - Plugin management via `lazy.nvim`
  - Focused on clarity, maintainability, and learning
- **Waybar configuration**
  - Floating style waybar with each module as pills.
  - Minimal config with Nerd Font Icons
- **Wofi configuration**
  - Honestly idk why I chose wofi.. I will change it
  - Added just coz its easy to set up and I have a decent working application launcher
  - Lot of issues: animation glitches, lag in loading, etc etc
- **Desktop Entries**
  - APP ITSELF IS NOT INSTALLED
  - ONLY DESKTOP ENTRIES AND ICONS(for some) ARE ADDED
  - Suggestion: Install chromium
    - Most of the desktop entries are chromium with --app flag only

## Repository Structure

.dotfiles/<br/>
├── assets/          # images and documentation assets<br/>
├── config/          # ~/.config applications<br/>
├── desktop-entries/ # desktop entries and some icons
├── home/            # files linked directly to $HOME<br/>
├── setup/<br/>
│   ├── install.sh   # installer entry point<br/>
│   ├── lib/         # shared installer utilities<br/>
│   └── modules/     # modular install scripts<br/>
└── themes/          # wallpapers and color themes<br/> 

---

## Wallpapers and Theming

Wallpapers live in `themes/wallpapers/` and are managed by `config/hypr/scripts/themectl`. The accent color is always calculated automatically from the wallpaper image, and is then applied to the Hyprland borders, Waybar and Wofi.

| Keybind | Action |
| --- | --- |
| `Super + W` | next wallpaper (accent color recalculated from it) |
| `Super + Y` | next color from `themes/colors/*.color` |

### The default wallpaper (`default.png`)

Every login starts on `themes/wallpapers/default.png`, not on whatever wallpaper was used last session.

- **The code expects a file named exactly `default.png`** in `themes/wallpapers/`. It is also the file `hyprpaper.conf` loads, so the name cannot change.
- **It must be a PNG.** If your wallpaper is a JPEG, WebP or any other format, convert it first (eg: `magick wallpaper.jpg default.png`) instead of just renaming it. A stray `default.jpg`, `default.webp`, etc. is ignored.
- **It is not part of the `Super + W` cycle.** `default.*` is excluded on purpose because it is only a copy of a wallpaper that is already in the cycle. Otherwise that wallpaper would show up twice.
- **Its accent color is calculated automatically at every login**, so replacing the file never leaves a stale color behind.
- **Changing it** is a simple copy that overwrites the old one. The original keeps its own name and stays in the cycle, so there is only ever one duplicate:

  ```bash
  cp themes/wallpapers/anime_wallpaper.png themes/wallpapers/default.png
  ```

- If `default.png` is missing, the first wallpaper (alphabetically) is used instead and a warning is printed.
- Only `default.png` is tracked by git. Every other wallpaper is gitignored, so on a fresh clone the default is the only wallpaper until you add your own.
- `hyprpaper.conf` uses the absolute path `~/.dotfiles/themes/wallpapers/default.png`, so the repo is expected to be cloned at `~/.dotfiles`.

### How the login sequence avoids flicker

The goal is that nothing visibly changes after the first frame:

1. **Blank screen first.** Hyprland shows a plain dark background (`misc:background_color`) instead of its built-in anime wallpaper/logo while it starts.
2. **hyprpaper draws `default.png` straight away** (from `hyprpaper.conf`). `themectl` does not re-send the wallpaper to hyprpaper at login, because reloading the same image would flicker.
3. **The accent is calculated and applied before Waybar starts.** `themectl init` calculates the accent from `default.png`, writes the color files and waits for every tool's `update_theme.sh` to finish.
4. **Waybar starts last**, so it opens already in the final accent color and never has to reload its styling.

This is wired up in `config/hypr/conf/autostart.conf` (`themectl init; waybar`). The `;` is deliberate, so Waybar still starts even if `themectl init` fails.

---

## Installation

### Requirements

- Hyprland (tested on Hyprland 0.51.1)
- Neovim (tested on NVIM v0.11.5)
- Waybar (tested on Waybar v0.13.0)
- Wofi (tested on Wofi v1.5.3)
- hyprpaper (wallpaper)
- ImageMagick (`magick`, calculates the accent color from the wallpaper)
- grim, slurp and wl-clipboard (screenshots)
- jq (used by the screenshot scripts)
- grimblast (area screenshot keybind)
- brightnessctl (brightness keys and Waybar backlight)
- playerctl (media keys)
- kitty (terminal) and nautilus (file manager), the defaults set at the top of `hyprland.conf`
- tree (optional, `cd` lists the directory with it if installed)
- Git
- Chromium Browser (if you want desktop entries)

### Quick Start

- Clone the repository:
  
  ```bash
  git clone https://github.com/itsdannydev/.dotfiles.git
  ```

- Run the `install.sh` script inside `.dotfiles/setup`. <br/>
  The installer uses symbolic links to keep the configuration in sync with this repository. <br/>
  For non-interactive install, run `install.sh` with the `-y` or `--yes-all` flag. <br/>
  Eg: `./install.sh -y`
  
  ```bash
  cd .dotfiles/setup/
  ./install.sh
  ```
  
  > During installation, if an existing configuration path already exists:
  > 
  > - any symlink at the target location is removed
  > - any non-symlink configuration is backed up to `~/.local/share/dotfiles-backups`
  >   
  >   <br/>

## Updating

After pulling run the install script again:

```bash
git pull
cd .dotfiles/setup
./install.sh
```

---

## Backups

If the dotfiles were installed using the script, any existing configurations (not symlinks) will be moved to `~/.local/share/dotfiles-backups`.
I'm not planning to make a script to automate the restoration process as of now, to not overcomplicate things. If the backup directory becomes cluttered over time, a restoration script may be added later.

### Restoring Backups

Backups are stored directly under `~/.local/share/dotfiles-backups` (one flat folder, not grouped by tool).

Each backup is named `<name>-<timestamp>`, where `<name>` is what the installer printed while installing and `<timestamp>` is `YYYY-MM-DD_HH-MM-SS`. Examples:

- `hypr-2026-03-19_14-02-11` → was `~/.config/hypr`
- `nvim-2026-03-19_14-02-11` → was `~/.config/nvim`
- `.bashrc-2026-03-19_14-02-11` → was `~/.bashrc`
- `youtube.desktop-2026-03-19_14-02-11` → was `~/.local/share/applications/youtube.desktop`

To restore manually, copy the backup back to where it came from, under its original name (without the `-<timestamp>` part):

- config folders (`hypr`, `nvim`, `waybar`, `wofi`) → `~/.config/<name>`
- home files (`.bashrc`, `.bash_profile`) → `~/<name>`
- desktop entries (`*.desktop`) → `~/.local/share/applications/<name>`

Existing files, directories, or symlinks at the destination should be removed before restoring.
