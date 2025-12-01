# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# configurations for zsh-vi-mode, called automagically
function zvm_config() {
	ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
	ZVM_CURSOR_STYLE_ENABLED=false
	ZVM_KEYTIMEOUT=0.2
}

# Load env (if not already loaded via .zshenv + ZDOTDIR)
[ -f "$ZDOTDIR/env.zsh" ] && . "$ZDOTDIR/env.zsh"

# ----- oh-my-zsh theme -----
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=(
  "robbyrussell"
  "agnoster"
  "amuse"
  "darkblood"
  "awesomepanda"
  "essembeh"
  "geoffgarside"
  "half-life"
  "jonathan"
  "kolo"
  "norm"
)
ZSH_THEME_RANDOM_QUIET=true

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(
	git
	zsh-vi-mode
	zsh-autosuggestions
	colored-man-pages
)

# source $ZDOTDIR/zsh_exports

# Load oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# zoxide
if (( $+commands[zoxide] )); then
	eval "$(zoxide init zsh)"
else
	echo '[from me dumbass] zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi

# ----- Extra config (aliases, keybindings, etc.) -----
[ -f "$ZDOTDIR/aliases.zsh" ] && . "$ZDOTDIR/aliases.zsh"

