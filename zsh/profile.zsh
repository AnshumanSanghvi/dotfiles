# profile.zsh
# ==============================================================================
# Login shells, before rc.zsh. Orders the environment files; each one is a
# separate topic. The order matters:
#   xdg   -> defines SDKMAN_DIR, CARGO_HOME, NVM_DIR ... that tools.zsh and path.zsh use
#   tools -> defines JAVA_HOME, MAVEN_HOME ... that path.zsh puts on PATH
# ==============================================================================
source "$ZDOTDIR/env/xdg.zsh"
source "$ZDOTDIR/env/tools.zsh"
source "$ZDOTDIR/env/path.zsh"

# Added by OrbStack: command-line tools and integration. Stays last, as it was.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :