# rc/prompt.zsh
# ==============================================================================
# Jovial prompt, installed by zplug. Phase 2 will load it as a plugin instead.
# ==============================================================================
_jovial="${XDG_DATA_HOME:-$HOME/.local/share}/jovial"
[[ -r $_jovial/jovial.zsh-theme ]]  && source "$_jovial/jovial.zsh-theme"
[[ -r $_jovial/jovial.plugin.zsh ]] && source "$_jovial/jovial.plugin.zsh"
unset _jovial