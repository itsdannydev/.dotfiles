![Dotfiles banner](assets/banner.png)

# Dotfiles

This repository contains my personal **dotfiles** — configuration files that define how my development environment behaves.

Dotfiles are used to customize tools, workflows, and editor behavior in a way that is:

- reproducible
- version-controlled
- portable across machines

The goal of this repo is not to be a “one-size-fits-all” setup, but a **personal, evolving configuration** that reflects how I work.

At the moment, this repository contains **only my Neovim configuration**. Other configs may be added later.

> Note: This setup is currently tested only on Linux. Other platforms may require adjustments.


## What’s inside (currently)

- **Neovim configuration**
  - Modular Lua-based setup
  - Plugin management via `lazy.nvim`
  - Focused on clarity, maintainability, and learning

---

## Installation

### Prerequisites

- Neovim (latest stable recommended)
- Git

### Quick Start

- Clone the repository:

  ```bash
  git clone https://github.com/itsdannydev/dotfiles.git
  ```
- Run the `install.sh` script inside `dotfiles/install`. <br/>
  The installer uses symbolic links to keep the configuration in sync with this repository.
  ```bash
  cd dotfiles/install/
  ./install.sh
  ```
  > During installation, if an existing configuration path already exists:
  > - any symlink at the target location is removed
  > - any non-symlink configuration is backed up to `~/.local/share/dotfiles-backups`


<br/><br/>
  Plugins will be installed automatically on first launch

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
