# rc/frameworks.zsh
# ==============================================================================
# Prezto and zplug. Both are replaced together in phase 2.
# ==============================================================================

# Prezto (reads $ZDOTDIR/.zpreztorc; that name is fixed by Prezto).
[[ -s $ZPREZTODIR/init.zsh ]] && source "$ZPREZTODIR/init.zsh"


# zplug calls compinit twice: `-C` at init (only to get `compdef`, which Prezto's compinit
# already provided) and a full scan without -C in `zplug load` (registers plugin
# completions); both write $ZPLUG_HOME/zcompdump inside the Homebrew Cellar.
# While zplug runs, a stand-in compinit skips the init call. On the late call it removes
# itself, restores the real autoloaded compinit and runs it against one cached dump under
# XDG (rebuilt when older than 20 h or when plugins.zsh changes).
if [[ -s $ZPLUG_HOME/init.zsh ]]; then
    compinit() {
        [[ $1 == -C ]] && return 0
        unfunction compinit
        autoload -Uz compinit
        setopt local_options extended_glob
        local dump="$XDG_CACHE_HOME/zplug/zcompdump"
        command mkdir -p "${dump:h}"
        if [[ -s $dump && ! $ZDOTDIR/plugins.zsh -nt $dump && -n $dump(#qN.mh-20) ]]; then
            compinit -C -d "$dump"
        else
            compinit -i -d "$dump" && touch "$dump"
        fi
    }

    source "$ZPLUG_HOME/init.zsh"
    [[ -s $ZDOTDIR/plugins.zsh ]] && source "$ZDOTDIR/plugins.zsh"
    if ! zplug check; then
        printf "Install missing zplug plugins? [y/N]: "
        if read -q; then echo; zplug install; fi
    fi
    zplug load

    # Safety net: if the late call never happened, make sure the real compinit is back.
    unfunction compinit 2>/dev/null
    autoload -Uz compinit
fi
