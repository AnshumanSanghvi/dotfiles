# rc.zsh
# ==============================================================================
# Read by every INTERACTIVE zsh (through the .zshrc stub). Orchestration only:
# the load order is the content, so it is documented here. Details live in rc/*.zsh.
# Section 1 also runs for IDE "environment readers" (interactive, no TTY).
# Section 2 is for a human at a terminal.
# PROFILING: ZSH_FORCE_INTERACTIVE_RC=1 forces section 2 without a TTY (see functions/timezsh).
# ==============================================================================

# top of rc.zsh (opt-in profiling; zero cost when ZSH_PROF is unset)
[[ -n $ZSH_PROF ]] && zmodload zsh/zprof

# ------------------------------------------------------------------------------
# 1. GLOBAL
# ------------------------------------------------------------------------------
# Hash lookup, no subprocess. Used by aliases/ and functions/.
_has() { (( $+commands[$1] )) }

# Google Cloud SDK: XDG location first, Downloads as a fallback until you move it.
_gcloud_root="${XDG_DATA_HOME:-$HOME/.local/share}/google-cloud-sdk"
[[ -d $_gcloud_root ]] || _gcloud_root="$HOME/Downloads/google-cloud-sdk"
[[ -d $_gcloud_root/bin ]] && path=( "$_gcloud_root/bin" $path )
unset _gcloud_root

# ------------------------------------------------------------------------------
# 2. INTERACTIVE
# ------------------------------------------------------------------------------
if [[ -o INTERACTIVE && ( -t 2 || -n $ZSH_FORCE_INTERACTIVE_RC ) ]]; then

    typeset -gU path fpath

    # Runtime dirs, cached_eval helper, fpath, autoload of functions/.
    source "$ZDOTDIR/rc/base.zsh"

    # Antidote bundle (plugins). Replaces Prezto + zplug. compinit is deliberately
    # NOT here; it runs in completion.zsh after every fpath addition.
    source "$ZDOTDIR/rc/plugins.zsh"

    # Shell, directory and history options (everything Prezto's environment, directory
    # and history modules used to set).
    source "$ZDOTDIR/rc/options.zsh"

    # Key bindings (everything Prezto's editor module used to set) + OMZ sudo.
    source "$ZDOTDIR/rc/keybindings.zsh"

    # compinit (once, cached) and completion styles.
    source "$ZDOTDIR/rc/completion.zsh"

    # Aliases. 00-defaults.zsh sorts first, so every file after it (yours) wins.
    for f in "$MYDOTS"/aliases/*.zsh(N); do source "$f"; done
    unset f

    # Lazy nvm/sdk/tldr/thefuck, cached fzf and zoxide init.
    source "$ZDOTDIR/rc/lazy.zsh"

    # Third-party integrations (iTerm2, ...).
    for f in "$MYDOTS"/integrations/*.zsh(N); do source "$f"; done
    unset f

    # Per-machine overrides (git-ignored; see local.zsh.example). After everything above
    # so it can override it, before the prompt.
    [[ -r $ZDOTDIR/local.zsh ]] && source "$ZDOTDIR/local.zsh"

    # Prompt last.
    source "$ZDOTDIR/rc/prompt.zsh"
fi


# bottom of rc.zsh: `||` form returns 0 when ZSH_PROF is unset, so `zsh -i -c exit` ends clean.
[[ -z $ZSH_PROF ]] || zprof