# env/path.zsh
# ==============================================================================
# PATH, MANPATH, INFOPATH and the Node entry.
# ==============================================================================

# No duplicates in these arrays.
typeset -gU cdpath fpath mailpath path

# ${VAR:+$VAR/bin} avoids a bare "/bin" entry when a variable is unset.
# $HOME/.local/bin stays early: uv installs uv/uvx there.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/bin(N)
  ${HOMEBREW_PREFIX}/{bin,sbin}(N)
  /usr/local/{bin,sbin}(N)
  ${JAVA_HOME:+$JAVA_HOME/bin}
  ${MAVEN_HOME:+$MAVEN_HOME/bin}
  ${GRADLE_HOME:+$GRADLE_HOME/bin}
  ${CARGO_HOME:+$CARGO_HOME/bin}
  ${GOPATH:+$GOPATH/bin}
  ${XDG_DATA_HOME}/npm/bin
  ${JBOSS_HOME}/bin
  $HOME/.rd/bin
  ${HOMEBREW_PREFIX}/opt/libpq/bin
  ${HOMEBREW_PREFIX}/opt/postgresql@17/bin
  ${HOME}/Library/Python/3.9/bin
  ${HOMEBREW_PREFIX}/opt/curl/bin
  $path
)

# Man and info pages. The trailing ":" in MANPATH keeps the system default search path.
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

# Newest installed Node on PATH without sourcing nvm.sh (which cost 771 ms).
# numeric_glob_sort makes v26.10.0 sort above v9.x; on[-1] takes the highest.
# DECISION: if your nvm default alias is NOT the newest version, use a fixed directory.
# Check with: cat ~/.local/share/nvm/alias/default
() {
  setopt local_options extended_glob numeric_glob_sort
  local -a _node
  _node=( ${NVM_DIR}/versions/node/v*(N/on[-1]) )
  (( $#_node )) && path=( $_node[1]/bin $path )
}

# The macOS dotnet installer adds a literal "~/.dotnet/tools" via /etc/paths.d, and zsh
# never expands "~" inside PATH.
path=( ${path/#\~\//$HOME/} )

# Last step: drop every entry that is not an existing directory.
path=( ${^path}(N-/) )