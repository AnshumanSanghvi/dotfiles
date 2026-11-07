# CHANGED: the old matcher-list repeated the same pattern three times (stages 2-4 were
# identical). Two stages give the same result.
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# CHANGED: `%F{..}`/`%f` prompt escapes replace "$fg[yellow]" and "$reset_color", which
# only worked if the `colors` function had already been autoloaded.
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}%B--- %d%b%f'
zstyle ':completion:*:messages'     format '%d'
zstyle ':completion:*:warnings'     format '%F{red}No matches for:%f %d'
zstyle ':completion:*:corrections'  format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# CHANGED: removed `menu select` and `list-colors`; Prezto's completion module already sets
# both (and a default LS_COLORS).