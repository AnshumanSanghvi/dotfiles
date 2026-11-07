# ZSH Plugins (zplug). Stage 2 replaces this file with an Antidote plugin list.
#
# CHANGED overall: removed plugins that duplicate Prezto/Homebrew or fought with other
# parts of this setup. Each is commented out with the reason, so you can restore it.

# ==============================================================================
# 1. CORE & LIBRARIES
# ==============================================================================
# REMOVED: lib/spectrum. Prezto's `spectrum` module already provides it.
# zplug "lib/spectrum", from:oh-my-zsh

# ==============================================================================
# 2. PRODUCTIVITY & UTILITIES
# ==============================================================================
# Double-tap ESC to add 'sudo' to the current command
zplug "plugins/sudo", from:oh-my-zsh

# REMOVED: plugins/fzf. fzf's own `cached_eval fzf --zsh` (in .zshrc) loads the same key
# bindings; loading both registered them twice.
# zplug "plugins/fzf", from:oh-my-zsh

# CHANGED: the old lines were `export AUTO_NOTIFY_IGNORE=( ... )`. Arrays cannot be
# exported in zsh; the plugin reads the shell variable, so a plain assignment is correct.
export AUTO_NOTIFY_THRESHOLD=20
AUTO_NOTIFY_IGNORE=("docker" "podman" "man" "sleep" "top" "htop" "vim" "less")
zplug "D3STY/cros-auto-notify-zsh"

# Prompt to load variables from .env when you cd into a dir
zplug "nocttuam/autodotenv"

# Suggest an alias if you type a command that has one
zplug "djui/alias-tips"


# ==============================================================================
# 3. DEVELOPMENT TOOLS
# ==============================================================================
# REMOVED: Docker, Compose and ripgrep completion plugins. OrbStack (already in your
# fpath), the docker CLI and Homebrew's ripgrep ship their own zsh completions.
# zplug "plugins/docker",         from:oh-my-zsh
# zplug "plugins/docker-compose", from:oh-my-zsh
# zplug "plugins/ripgrep",        from:oh-my-zsh

# REMOVED: lukechilds/zsh-nvm. It expects nvm.sh inside $NVM_DIR, but your nvm is the
# Homebrew one. .zshrc already lazy-loads it, so this plugin would only fight with it.
# zplug "lukechilds/zsh-nvm"

# KEPT: completions and aliases that nothing else provides.
zplug "plugins/gradle", from:oh-my-zsh
zplug "caarlos0-graveyard/zsh-pg"

# REMOVED: zsh-users/zsh-completions. Prezto bundles it (modules/completion/external/src
# is in your fpath) and Homebrew's copy is also in fpath: three copies of the same thing.
# zplug "zsh-users/zsh-completions", defer:2

# ==============================================================================
# 4. GIT ENHANCEMENTS
# ==============================================================================
zplug "wfxr/forgit"
zplug "unixorn/git-extra-commands"