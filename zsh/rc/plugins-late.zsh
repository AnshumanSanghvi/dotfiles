# rc/plugins-late.zsh
# ==============================================================================
# The LATE plugin list (plugins-late.txt): plugins that must load after compinit
# (rc/completion.zsh) and that bind or wrap line-editor widgets.
# ==============================================================================

# Select the emacs keymap BEFORE these plugins load: they bind in the keymap that is
# current when they load, and VISUAL=vim would otherwise leave zsh in vi mode.
bindkey -e

# zsh-autosuggestions settings, read when the plugin loads. Suggestions come from history
# (the default strategy). No suggestion is computed for buffers over 100 characters, so
# pasting a large block stays fast. The suggestion is drawn in grey (default fg=8); if it
# is invisible with your iTerm2 colour scheme, set ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE here,
# e.g. 'fg=244'. Right arrow or End accepts it, and your Ctrl-Right accepts one word.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100

(( $+functions[_load_plugin_list] )) && _load_plugin_list plugins-late
unfunction _load_plugin_list 2>/dev/null

# --- fzf-tab settings ---
# zstyles are read at completion time, so setting them after the plugin has loaded works.
# Applied only when fzf-tab is active, so completion falls back to zsh's own menu otherwise.
# (lazy.zsh runs `fzf --zsh` later, which rebinds Tab to fzf-completion; that widget
# remembers the previous binding, fzf-tab-complete, and falls back to it.)
if (( $+widgets[fzf-tab-complete] )); then
    # zsh's own menu must be off so fzf-tab can capture the unambiguous prefix. The
    # `menu select` entries in completion.zsh are more specific than the generic one, so
    # they are overridden too.
    zstyle ':completion:*' menu no
    zstyle ':completion:*:*:*:*:*' menu no
    zstyle ':completion:*:*:kill:*' menu no
    zstyle ':completion:*:*:cd:*:directory-stack' menu no
    # Group headers must be plain text: fzf-tab ignores escape sequences in this format.
    zstyle ':completion:*:descriptions' format '[%d]'
    # Keep git's own branch order for `git checkout`.
    zstyle ':completion:*:git-checkout:*' sort false
    # Switch between groups with < and >.
    zstyle ':fzf-tab:*' switch-group '<' '>'
    # Preview a directory's contents while completing cd.
    (( $+commands[eza] )) && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
fi
