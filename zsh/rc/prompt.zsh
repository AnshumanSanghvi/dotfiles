# rc/prompt.zsh
# ==============================================================================
# Jovial prompt, loaded from a local clone:
#   git clone https://github.com/zthxxx/jovial.git ~/.local/share/jovial
# It lives outside Antidote's cache so that a plugin purge cannot delete it.
# ==============================================================================
_jovial="${XDG_DATA_HOME:-$HOME/.local/share}/jovial"
[[ -r $_jovial/jovial.zsh-theme ]]  && source "$_jovial/jovial.zsh-theme"
[[ -r $_jovial/jovial.plugin.zsh ]] && source "$_jovial/jovial.plugin.zsh"
unset _jovial