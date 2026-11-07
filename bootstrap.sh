#!/usr/bin/env bash
# bootstrap.sh: set up this zsh configuration on a new macOS machine. Safe to re-run.
set -euo pipefail

repo_url="https://github.com/AnshumanSanghvi/dotfiles.git"
dest="$HOME/.mydotfiles"
zdotdir_line='export ZDOTDIR="$HOME/.mydotfiles/zsh"'

# 1. The repository itself (skipped when this script is run from an existing clone).
if [[ ! -d $dest/.git ]]; then
    git clone "$repo_url" "$dest"
fi

# 2. ZDOTDIR for every zsh. Appended, so an existing /etc/zshenv is kept.
if ! grep -qsF "$zdotdir_line" /etc/zshenv; then
    echo "Adding ZDOTDIR to /etc/zshenv (needs sudo)"
    echo "$zdotdir_line" | sudo tee -a /etc/zshenv >/dev/null
fi

# 3. Homebrew packages (antidote, eza, fzf, ...).
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required first: https://brew.sh" >&2
    exit 1
fi
brew bundle --file="$dest/Brewfile"

# 4. Jovial prompt (loaded from zsh/rc/prompt.zsh; kept outside Antidote's cache).
if [[ ! -d $HOME/.local/share/jovial/.git ]]; then
    mkdir -p "$HOME/.local/share"
    git clone https://github.com/zthxxx/jovial.git "$HOME/.local/share/jovial"
fi

# 5. Git hooks (the pre-commit check lives in .githooks/, added by a later change).
if [[ -d $dest/.githooks ]]; then
    git -C "$dest" config core.hooksPath .githooks
fi

echo "Done. Open a new terminal: the first start clones the plugins in zsh/plugins.txt."
