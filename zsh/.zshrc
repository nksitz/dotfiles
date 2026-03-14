# Exports
export EDITOR="nvim"
export VISUAL="nvim"

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='eza -lha --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='eza --tree --level=2 --long --icons --git -a'
alias nv='nvim'

# Prompt
eval "$(starship init zsh)"
fastfetch
