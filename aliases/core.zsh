# aliases/core.zsh
# ==============================================================================
# Replacements for, and defaults on, standard commands. Sourced after Prezto, so
# these override Prezto's `utility` aliases.
# ==============================================================================

# --- Replacements ---
alias python='python3'
alias pip='pip3'
if _has safe-rm;   then alias rm="$commands[safe-rm]"; fi
if _has prettyping; then alias ping='prettyping'; fi
# duf replaces df (the old file aliased it over du).
if _has duf;       then alias df='duf'; fi

# eza: --icons, --classify, --color and --color-scale take an OPTIONAL value, so they are
# written with =auto and each alias ends with a valueless flag. A bare option last in an
# alias swallows the first path you type.
if _has eza; then
    alias ls='eza --icons=auto --classify --color=auto --group-directories-first'
    alias ll='eza --long --header --icons=auto --classify --color=auto --binary --group --modified --group-directories-first'
    alias la='eza --oneline --icons=auto --classify --color=auto --all --binary --group --group-directories-first'
    alias lal='eza --long --header --icons=auto --classify --color=auto --all --binary --group --modified --group-directories-first'
    alias lx='eza -lbhHigmuSa@ --time-style=long-iso --color-scale --icons=auto'
    alias tree='eza --tree'
fi

if _has bat; then
    alias cat='bat'
    alias batsh='bat -l bash'
    alias batd='bat -l Dockerfile'
    alias catsh='batsh'
    alias catd='batd'
    alias batl='bat --color=always --paging=never -l log'
fi

# --- Defaults on standard commands ---
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias cls='command clear && ls'

# --archive implies --recursive; --compress only helps on slow networks.
alias rsync='rsync --progress --partial --archive --human-readable'

# --color=always would put escape codes into every pipe.
alias grep='grep --color=auto'
alias zgrep='zgrep --color=auto'
# The old "numbered, with filename, case-insensitive" grep, under an explicit name.
alias grepn='grep -in --with-filename'

if _has ncdu;  then alias ncdu='ncdu --color=dark -e'; fi
if _has procs; then alias procs='procs --color=always --watch-interval=3 --watch --sortd=mem'; fi

# --- Tools whose config was relocated (from xdg.aliases) ---
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
# Single quotes: $XDG_DATA_HOME is read when wget runs.
alias wget='wget -c --hsts-file="$XDG_DATA_HOME/wget-hsts"'
# Maven needs no alias: MAVEN_ARGS in env/xdg.zsh covers it (Maven >= 3.9).