# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
# (only if Rust is installed, otherwise this errors on every login)
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
