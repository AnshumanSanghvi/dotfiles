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

# 4. Homebrew zsh as the login shell. The Brewfile installed it; this registers it in
#    /etc/shells and selects it with chsh. Skipped, with a warning, if the Homebrew zsh does
#    not read /etc/zshenv (checked with ZDOTDIR unset), so a login shell that ignores this
#    configuration is never selected.
brew_zsh="$(brew --prefix)/bin/zsh"
if [[ ! -x $brew_zsh ]]; then
    echo "warning: $brew_zsh not found; leaving the login shell unchanged" >&2
elif [[ $(env -u ZDOTDIR "$brew_zsh" -c 'print -r -- $ZDOTDIR') != "$HOME/.mydotfiles/zsh" ]]; then
    echo "warning: $brew_zsh does not read /etc/zshenv; leaving the login shell unchanged" >&2
else
    if ! grep -qxF "$brew_zsh" /etc/shells; then
        echo "Registering $brew_zsh in /etc/shells (needs sudo)"
        echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
    fi
    current_shell="$(dscl . -read "/Users/$(id -un)" UserShell | awk '{print $2}')"
    if [[ $current_shell != "$brew_zsh" ]]; then
        echo "Changing the login shell from $current_shell to $brew_zsh (asks for your password)"
        chsh -s "$brew_zsh"
    fi
fi

# 5. Jovial prompt (loaded from zsh/rc/prompt.zsh; kept outside Antidote's cache).
if [[ ! -d $HOME/.local/share/jovial/.git ]]; then
    mkdir -p "$HOME/.local/share"
    git clone https://github.com/zthxxx/jovial.git "$HOME/.local/share/jovial"
fi

# 6. Git hooks (the pre-commit check lives in .githooks/, added by a later change).
if [[ -d $dest/.githooks ]]; then
    git -C "$dest" config core.hooksPath .githooks
fi

echo "Done. Open a new terminal (the login shell change applies to new windows only);"
echo "the first start clones the plugins in zsh/plugins.txt."
