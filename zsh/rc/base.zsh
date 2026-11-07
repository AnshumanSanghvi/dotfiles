# rc/base.zsh
# ==============================================================================
# Runtime directories, the cached_eval helper, fpath and function autoload.
# Must run BEFORE plugins.zsh and completion.zsh so compinit sees the final fpath.
# ==============================================================================

# --- Runtime directories the XDG variables point to ---
# zsh, less and the Python/Node REPLs do not create them. The test keeps steady-state
# startup fork-free.
[[ -d $XDG_STATE_HOME/zsh && -d $XDG_STATE_HOME/less && -d $XDG_CACHE_HOME/zsh ]] || \
    command mkdir -p "$XDG_STATE_HOME"/{zsh,less,python,node} "$XDG_CACHE_HOME/zsh"
[[ -d $XDG_RUNTIME_DIR ]] || command mkdir -m 700 -p "$XDG_RUNTIME_DIR"

# --- cached_eval: cache the output of `eval "$(tool init zsh)"` ---
# Regenerates only when the tool's binary is newer than the cache file.
cached_eval() {
    (( $+commands[$1] )) || return 0
    local key="${(j:_:)argv}"; key="${key//[^[:alnum:]_-]/}"
    local f="$XDG_CACHE_HOME/zsh/eval_${key}.zsh"
    if [[ ! -s $f || $commands[$1] -nt $f ]]; then
        "$@" >| "$f" 2>/dev/null
    fi
    source "$f"
}

# --- fpath and function autoload ---
# The functions directory is visible (no leading dot).
fpath=(
    "$MYDOTS/functions"
    ${HOMEBREW_PREFIX}/share/zsh/site-functions(N-/)
    ${HOMEBREW_PREFIX}/share/zsh-completions(N-/)
    $fpath
)
autoload -Uz "$MYDOTS"/functions/*(N.:t)