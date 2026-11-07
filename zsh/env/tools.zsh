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

# --- Zsh frameworks (phase 1; phase 2 replaces both) ---
export ZPLUG_HOME="$HOMEBREW_PREFIX/opt/zplug"
export ZPLUG_REPOS="$XDG_DATA_HOME/zplug/repos"
export ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"
# CHANGED: .zprezto -> prezto. Prezto's init.zsh derives ZPREZTODIR from its own location,
# so this export only matters for rc/frameworks.zsh.
export ZPREZTODIR="$MYDOTS/prezto"

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