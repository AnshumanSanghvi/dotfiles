# aliases/shell.zsh
# ==============================================================================
# Aliases about the shell itself: pipe shortcuts, dotfiles, typos.
# ==============================================================================

# --- Global aliases (expand anywhere on the line; "@" avoids clashes with real arguments) ---
alias -g @L='| less'
alias -g @G='| grep'
alias -g @W='| wc -l'
alias -g @J='| jq'
alias -g @C='| pbcopy'

alias tracert='traceroute'

# --- Dotfiles and shell inspection ---
# CHANGED: opens rc.zsh (the .zshrc stub only contains one line now).
alias .zshrc='subl "$ZDOTDIR/rc.zsh"'
alias printpath='print -l $path'
# Renamed from `ag`, which shadows the silver-searcher binary.
alias als='alias | grep -i '

# --- Typos ---
alias clr='clear'
alias clearrr='clear'
alias cclear='clear'
alias claer='clear'
alias clera='clear'
alias cler='clear'
alias docker-componse='docker compose'
alias cd..='cd ..'
alias cd...='cd ..'