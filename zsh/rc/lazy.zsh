# rc/lazy.zsh
# ==============================================================================
# Slow tools, loaded on first use or from a cache.
# ==============================================================================

# nvm: eager loading cost 771 ms. Node is already on PATH (env/path.zsh); only the `nvm`
# command is loaded on first use. --no-use stops it from changing the PATH you have.
nvm() {
    unfunction nvm
    [[ -s $HOMEBREW_PREFIX/opt/nvm/nvm.sh ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" --no-use
    nvm "$@"
}

# SDKMAN: about 75 ms. java/mvn/gradle are already on PATH via env/tools.zsh.
sdk() {
    unfunction sdk
    [[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
}

# fzf's own integration (fzf >= 0.48) and zoxide, both cached.
cached_eval fzf --zsh
cached_eval zoxide init zsh

# direnv: per-directory environments from .envrc files, active only after `direnv allow`.
# Replaces the autodotenv plugin. To load a plain .env file, put `dotenv` in .envrc.
cached_eval direnv hook zsh

# tldr: the completion list is built on first use instead of on every shell start.
export TLDR_HEADER='green bold'
if [[ -x $HOME/.local/bin/tldr ]]; then
    tldr() {
        unfunction tldr
        compctl -k "($(command tldr --list 2>/dev/null))" tldr
        command tldr "$@"
    }
fi

# thefuck starts Python, so it loads on first use.
if (( $+commands[thefuck] )); then
    fuck() { unfunction fuck; eval "$(thefuck --alias fuck)"; fuck "$@" }
fi