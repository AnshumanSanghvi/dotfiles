# Brewfile: everything the zsh config expects.
#   brew bundle --file=~/.mydotfiles/Brewfile
# The "optional" sections are only used when present (aliases check with `_has`).

# --- shell and plugin infrastructure ---
brew "zsh"
brew "antidote"             # plugin manager (zsh/plugins.txt)
brew "zsh-completions"      # extra completions, added to fpath in rc/base.zsh
brew "gradle-completion"    # completion for the gradle() wrapper in functions/gradle
brew "hyperfine"            # used by the timezsh function
brew "direnv"               # per-directory environments (cached hook in rc/lazy.zsh)

# --- used by lazy.zsh, aliases and env/tools.zsh ---
brew "eza"                  # ls replacement (aliases/core.zsh, functions/latest)
brew "bat"                  # cat replacement
brew "fzf"                  # key bindings and completion, cached in lazy.zsh
brew "zoxide"               # smarter cd, cached in lazy.zsh
brew "ripgrep"              # FZF_DEFAULT_COMMAND uses rg
brew "nvm"                  # lazy-loaded in lazy.zsh

# --- optional: aliases are defined only when these exist ---
brew "bandwhich"
brew "bottom"               # provides btm
brew "duf"
brew "htop"
brew "mpv"
brew "ncdu"
brew "nnn"
brew "prettyping"
brew "procs"
brew "pv"
brew "safe-rm"
brew "yt-dlp"
brew "coreutils"            # g-prefixed GNU tools, wrapped in aliases/00-defaults.zsh

# --- optional: applications the config integrates with ---
# cask "iterm2"             # integrations/iterm2.zsh
# cask "orbstack"           # env/profile.zsh, dkreboot in aliases/docker.zsh
# cask "sublime-text"       # EDITOR=subl -w
# brew "thefuck"            # lazy `fuck` in lazy.zsh (check the formula is still available)
