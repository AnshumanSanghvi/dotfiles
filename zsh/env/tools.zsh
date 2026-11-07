# env/tools.zsh
# ==============================================================================
# Default apps, tool homes, framework locations, pager. Exports only.
# ==============================================================================

# --- Default apps ---
# (the old LANG fallback is gone: env.zsh always sets LANG)
if [[ -z $BROWSER && $OSTYPE == darwin* ]]; then export BROWSER=open; fi
export EDITOR="${EDITOR:-subl -w}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"

# --- Java / JVM ---
export JBOSS_HOME="$HOMEBREW_PREFIX/opt/wildfly-as/libexec"
# SDKMAN's "current" symlinks, so non-interactive shells find java/mvn/gradle.
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export MAVEN_HOME="$SDKMAN_DIR/candidates/maven/current"
export GRADLE_HOME="$SDKMAN_DIR/candidates/gradle/current"

# --- Rust ---
[[ -f $CARGO_HOME/env ]] && source "$CARGO_HOME/env"

# --- Postgres ---
# CHECK: Homebrew's postgresql@17 keeps its data in $HOMEBREW_PREFIX/var/postgresql@17.
export PGDATA="$HOMEBREW_PREFIX/var/postgres"

# --- Antidote (zsh plugin manager) ---
# Plugin clones live here. Kept in the cache directory because everything in it can be
# rebuilt by re-running the bundle.
export ANTIDOTE_HOME="$XDG_CACHE_HOME/antidote"

# --- fzf ---
# A command that prints file names (fzf's default would list candidates by running itself).
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- GTK/GLib via Homebrew ---
export GSETTINGS_SCHEMA_DIR="$HOMEBREW_PREFIX/share/glib-2.0/schemas/"

# --- Telemetry opt-outs ---
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# --- Pager (less) ---
# -X is left out so the mouse wheel can scroll.
[[ -z $LESS ]] && export LESS='-g -i -M -R -S -w -z-4'
if [[ -z $LESSOPEN ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
# Do not clear the screen after quitting a man page.
export MANPAGER="less -X"

# --- Colours that Prezto used to export (your ':prezto:*:*' color 'yes' enabled them) ---
# Coloured man pages through less.
export LESS_TERMCAP_mb=$'\E[01;31m' LESS_TERMCAP_md=$'\E[01;31m' LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[00;47;30m' LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# BSD ls and grep colours (GREP_COLOR is for macOS grep, GREP_COLORS for GNU grep).
export LSCOLORS="${LSCOLORS:-exfxcxdxbxGxDxabagacad}"
export GREP_COLOR="${GREP_COLOR:-37;45}"
export GREP_COLORS="${GREP_COLORS:-mt=$GREP_COLOR}"