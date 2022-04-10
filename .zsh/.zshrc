export ALLEGO_HOME=~/work/projects/allego

# set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/anshuman/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
#ZSH_THEME_RANDOM_CANDIDATES=("bureau" "geoffgarside" "af-magic" "robbyrussell")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=5

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"


## Configure zsh history
# source .zsh history config file
if [ -f ~/.zsh/.zsh_history_config ];
then
        . ~/.zsh/.zsh_history_config
fi

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(alias-tips autoupdate colored-man-pages colorize command-not-found docker docker-compose forgit fuzzy-sys fzf-zsh-plugin gitfast httpie last-working-dir ripgrep rsync safe-paste sdk sublime sudo systemadmin systemd ubuntu zsh-sdkman)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# add diff-so-fancy script to path
export PATH=/home/anshuman/diff-so-fancy:$PATH

# add cargo (rust) installed binaries to path e.g bandwhich
export PATH=/home/anshuman/.cargo/bin:$PATH

## TLDR
# add TLDR bin to path
export PATH=$PATH:~/bin
# add TLDR autocompletion support
complete -W "$(tldr 2>/dev/null --list)" tldr

#automatically cd to entered path
setopt AUTO_CD

#glob/auto-complete insensitive of case
setopt NO_CASE_GLOB

# try to guess correct command or dir if you entered something zsh does not recognize
setopt CORRECT
setopt CORRECT_ALL

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

#   Add color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Don't check mail when opening terminal.
unset MAILCHECK

# configure zsh History
# Nearly infinite history; essential to building a cli 'library' to use with fzf/etc
export HISTSIZE=100000
export SAVEHIST=100000
# share it across sessions
setopt share_history
# add timestamps to history
setopt extended_history
# don't record dupes in history
setopt hist_ignore_all_dups
# remove command line from history list when first character on the line is a space
setopt hist_ignore_space
# remove superflous blanks
setopt hist_reduce_blanks

#install nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source all aliases from ~/.aliases folder
for f in ~/.aliases/*.aliases; do source $f; done

# "kitty" command auto complete for kitty terminal
kitty + complete setup zsh | source /dev/stdin


# set maven home
MAVEN_HOME="/home/anshuman/.sdkman/candidates/maven/current/"

# add rust application binaries to path
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# zoxide initialize
eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/anshuman/.sdkman"
[[ -s "/home/anshuman/.sdkman/bin/sdkman-init.sh" ]] && source "/home/anshuman/.sdkman/bin/sdkman-init.sh"

# run shell scripts for app specific configurations
for f in ~/.appconfig/*.zsh; do zsh $f; done

eval "$(starship init zsh)"
