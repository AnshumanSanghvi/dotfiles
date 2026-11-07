# rc/plugins-late.zsh
# ==============================================================================
# The LATE plugin list (plugins-late.txt): plugins that must load after compinit
# (rc/completion.zsh) and that bind or wrap line-editor widgets.
# ==============================================================================

# Select the emacs keymap BEFORE these plugins load: they bind in the keymap that is
# current when they load, and VISUAL=vim would otherwise leave zsh in vi mode.
bindkey -e

(( $+functions[_load_plugin_list] )) && _load_plugin_list plugins-late
unfunction _load_plugin_list 2>/dev/null
