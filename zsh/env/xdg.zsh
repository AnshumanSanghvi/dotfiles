# xdg directory compatibility

# Rule: config -> XDG_CONFIG_HOME, caches -> XDG_CACHE_HOME, durable data -> XDG_DATA_HOME,
# history/logs/state -> XDG_STATE_HOME.

# --- Java / JVM ---
export SDKMAN_DIR="$XDG_DATA_HOME"/sdkman
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# NEW: Maven >= 3.9 reads MAVEN_ARGS, so IDEs, mvnw and scripts get your relocated
# settings too (the `mvn` alias in xdg.aliases only helps interactive shells).
# VERIFY first: `mvn -v` must report 3.9.0 or newer.
export MAVEN_ARGS="-gs $XDG_CONFIG_HOME/maven/settings.xml"

# --- Node / JavaScript ---

export NVM_DIR="$XDG_DATA_HOME"/nvm
export NPM_PATH="$XDG_DATA_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config/npmrc"

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm

# NEW: the Node REPL history normally goes to ~/.node_repl_history.
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history"

# --- Python (NEW) ---
# PYTHON_HISTORY needs Python 3.13+ (your thefuck cache shows 3.12 and 3.13 in use).
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
# Keeps __pycache__ directories out of your source trees.
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"


# --- Rust ---
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# --- Database (Postgres) ---
# CHANGED: history is *state*, not data (XDG spec): moved to XDG_STATE_HOME.
# Migration command is in Part 5.
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
# NEW:
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
# OPTIONAL (uncomment only after moving the files, see Part 5; an env var pointing at a
# missing file silently disables your existing ~/.pgpass / ~/.psqlrc):
# export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
# export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
# export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# --- Go ---
export GOPATH="$XDG_DATA_HOME"/go

# --- Cloud ---
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config:$HOME/.kube/config"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"

# --- Tools ---
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export SONARLINT_USER_HOME="$XDG_DATA_HOME"/sonarlint

# --- Zsh Frameworks ---
# Oh-My-Zsh plugins loaded through zplug expect this variable.
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
# export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/"

# --- CLI Utilities ---
# Zoxide
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"

# Less History
# CHANGED: history is state, so less history moves to XDG_STATE_HOME (directory created in
# .zshrc, migration command in Part 5).
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Zsh History
# Zsh history is NOT set here. macOS /etc/zshrc runs after .zprofile and resets HISTFILE,
# so an export here is overwritten. HISTFILE, HISTSIZE and SAVEHIST are set in rc/options.zsh.

# Editors (Vim/Neovim) Override ~/.vimrc location
export GVIMINIT='let $MYGVIMRC=$XDG_CONFIG_HOME/vim/gvimrc | source $MYGVIMRC'
export VIMINIT='let $MYVIMRC=$XDG_CONFIG_HOME/vim/vimrc | source $MYVIMRC'

# Android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# --- .NET / NuGet and Sonar (moved from aliases/xdg.aliases) ---
# All are caches, so setting the variable and deleting the old folder is safe.
export NUGET_PACKAGES="$XDG_CACHE_HOME/nuget/packages"
export NUGET_HTTP_CACHE_PATH="$XDG_CACHE_HOME/nuget/v3-cache"
export NUGET_PLUGINS_CACHE_PATH="$XDG_CACHE_HOME/nuget/plugins-cache"
export SONAR_USER_HOME="$XDG_CACHE_HOME/sonar"