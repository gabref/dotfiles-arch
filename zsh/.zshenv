# https://superuser.com/questions/1840395/complete-overview-of-bash-and-zsh-startup-files-sourcing-order

# Point zsh to use XDG-style config dir
export ZDOTDIR="$HOME/.config/zsh"

# Load further environment config from there (if present)
if [ -f "$ZDOTDIR/env.zsh" ]; then
  . "$ZDOTDIR/env.zsh"
fi
