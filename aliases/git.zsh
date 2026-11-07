# git aliases

alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log'
# pull submodules
alias gsub="git submodule update --remote"

# git log for each branches
alias gblog="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# view a log of latest commits with author and commit message
alias glog="git log --graph --abbrev-commit --decorate --date=relative --all"

