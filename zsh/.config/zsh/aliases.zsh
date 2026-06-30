# zsh-auto-suggestions
bindkey '^e' autosuggest-accept

# aliases
# For a full list of active aliases, run `alias`.

# ls
alias l="eza --icons"
alias ll="eza -lh --git --icons"
alias la="eza -lha --icons"
alias llt="eza -1 --icons --tree -a --git-ignore"

alias vim="nvim"

# alias open='/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'

# Git shortcuts
alias gs='git status'
alias gl='git log --oneline --graph --decorate'

alias notepad='/mnt/c/Windows/System32/notepad.exe'

alias adb='/mnt/c/Users/codec/AppData/Local/Android/Sdk/platform-tools/adb.exe'
alias winjava="'/mnt/c/Program Files/Android/Android Studio/jbr/bin/java.exe'"

# eval `keychain --quiet --agents ssh --eval \
# 	/home/gabre/.ssh/id_github_ed25519 \
# 	/home/gabre/.ssh/id_embed_ed25519 \
# 	/home/gabre/.ssh/id_gitlab_ed25519 \
# 	/home/gabre/.ssh/bethel_key \
# 	`
