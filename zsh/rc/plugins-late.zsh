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
