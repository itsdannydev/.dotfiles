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

## Installation

### Requirements

- Hyprland (tested on Hyprland 0.51.1)
- Neovim (tested on NVIM v0.11.5)
- Waybar (tested on Waybar v0.13.0)
- Wofi (tested on Wofi v1.5.3)
- Git
- Chromium Browser (if you want desktop entries)

### Quick Start

- Clone the repository:
  
  ```bash
  git clone https://github.com/itsloki-dev/.dotfiles.git
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

Backups are stored under `~/.local/share/dotfiles-backups`, grouped by domain and tool.

Current layout:

- `config/<tool>/<timestamp>/` → backed-up config directories
- `home/<file>/<timestamp>` → backed-up home dotfiles

To restore manually:

- Copy the desired backup from:
  - `config/<tool>/<timestamp>` → `~/.config/<tool>`
  - `home/<file>/<timestamp>` → `~/<file>`

Existing files, directories, or symlinks should be removed before restoring.
