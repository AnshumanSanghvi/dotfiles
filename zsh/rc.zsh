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

    # Prezto + zplug (phase 1). Prezto runs the single cached compinit.
    source "$ZDOTDIR/rc/frameworks.zsh"

    # Shell and history options, after Prezto so they can override it.
    source "$ZDOTDIR/rc/options.zsh"

    # Key bindings, after Prezto's editor module.
    source "$ZDOTDIR/rc/keybindings.zsh"

    # Completion styles.
    source "$ZDOTDIR/rc/completion.zsh"

    # Aliases, after Prezto: Prezto's `utility` module defines ls/grep/rm/du, and yours
    # must win. Alphabetical order, so core.zsh loads first.
    for f in "$MYDOTS"/aliases/*.zsh(N); do source "$f"; done
    unset f

    # Lazy nvm/sdk/tldr/thefuck, cached fzf and zoxide init.
    source "$ZDOTDIR/rc/lazy.zsh"

    # Third-party integrations (iTerm2, ...).
    for f in "$MYDOTS"/integrations/*.zsh(N); do source "$f"; done
    unset f

    # Prompt last.
    source "$ZDOTDIR/rc/prompt.zsh"
fi

# bottom of rc.zsh
[[ -n $ZSH_PROF ]] && zprof