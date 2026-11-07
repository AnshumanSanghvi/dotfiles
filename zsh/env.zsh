# env.zsh
# ==============================================================================
# Sourced from .zshenv, so it runs for EVERY zsh: login, interactive, scripts, IDEs.
# Exports only: no output, no subprocesses.
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Locations
# ------------------------------------------------------------------------------
export MYDOTS="$HOME/.mydotfiles"

# ZDOTDIR is a visible directory (no leading dot).
export ZDOTDIR="$MYDOTS/zsh"

# Skip the system-wide compinit that some Linux /etc/zshrc files run. macOS never does,
# so this only matters if these dotfiles are shared with a Linux host.
export skip_global_compinit=1

# ------------------------------------------------------------------------------
# 2. Homebrew (Apple Silicon)
# ------------------------------------------------------------------------------
# MOVED above the XDG block. XDG_DATA_DIRS below uses HOMEBREW_PREFIX, which used to be
# defined later in the file, so the old value ended with a bare "/share".
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export HOMEBREW_NO_ANALYTICS=1

# ------------------------------------------------------------------------------
# 3. Locale and session
# ------------------------------------------------------------------------------
# LANG only: LC_ALL would override every per-app and per-ssh locale.
export LANG=en_US.UTF-8
# Disable macOS "Save/Restore Shell State".
export SHELL_SESSIONS_DISABLE=1

# ------------------------------------------------------------------------------
# 4. XDG Base Directory Specification
# ------------------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/tmp/$UID"      # created with mode 700 in rc/base.zsh

# Assigned, not appended. This file runs in every nested zsh and script, so appending
# the previous value ("${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}") made the variable grow each time.
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOMEBREW_PREFIX/share"
export XDG_CONFIG_DIRS="/etc/xdg"