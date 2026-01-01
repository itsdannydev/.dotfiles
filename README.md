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

### Neovim setup

- Clone the repository:

  ```bash
  git clone https://github.com/itsdannydev/dotfiles.git
  ```

- If you have an existing Neovim config, back it up first.
  Else, skip to next step
  ```bash
  mv ~/.config/nvim ~/.config/nvim.backup
  ```
- Create a symbolic link so Neovim can pick up the configuration
  ```bash
  ln -s ~/dotfiles/nvim ~/.config/nvim
  ```
  > Update the source path according to where you did `git clone...` in step 1
- Start Neovim
  ```bash
  nvim
  ```
  Plugins will be installed automatically on first launch
