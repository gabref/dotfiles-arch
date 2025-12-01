# ===== XDG paths =====
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# ===== PATHs (order matters) =====
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Scripts
export PATH="$XDG_CONFIG_HOME/zsh/my_scripts:$PATH"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST-$ZSH_VERSION"

# n (node version manager)
export N_PREFIX="$HOME/n"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH="$PATH:$N_PREFIX/bin"

# Go (only keep this if you really have Go in /usr/local/go)
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# Language / editor
export LANG="en_US.UTF-8"
export EDITOR="nvim"

# Cargo environment (if present)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
