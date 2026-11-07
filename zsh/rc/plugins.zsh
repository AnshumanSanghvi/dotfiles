# rc/plugins.zsh
# ==============================================================================
# Antidote: a static plugin bundle. Replaces Prezto and zplug.
#
# HOW IT WORKS
#  - plugins.txt is compiled by `antidote bundle` into ONE plain zsh file.
#  - The bundle is rebuilt only when plugins.txt is newer than it, so a normal
#    startup is a single `source`, with no plugin-manager code running.
#  - `antidote` itself is a lazy stub, so its code loads only when you call it
#    (antidote update | list | purge).
#  - compinit is NOT run here; rc/completion.zsh runs it once, after fpath is final.
# ==============================================================================

# Plugins assume these are autoloaded; Prezto's environment module used to do it.
autoload -Uz add-zsh-hook is-at-least colors && colors

# cros-auto-notify reads these at precmd time. They moved here from the old zplug
# list because that file no longer exists.
export AUTO_NOTIFY_THRESHOLD=20
AUTO_NOTIFY_IGNORE=("docker" "podman" "man" "sleep" "top" "htop" "vim" "less")

_plugin_list="$ZDOTDIR/plugins.txt"
_plugin_bundle="$XDG_CACHE_HOME/zsh/plugins.zsh"

if [[ -r $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh ]]; then

    # Lazy stub: the first call loads the real function, then re-dispatches.
    antidote() {
        unfunction antidote
        source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
        antidote "$@"
    }

    # Rebuild when the list changed. Written to a temp file first, so an offline
    # failure cannot leave an empty bundle behind.
    if [[ ! -s $_plugin_bundle || $_plugin_list -nt $_plugin_bundle ]]; then
        antidote bundle <"$_plugin_list" >|"$_plugin_bundle.tmp" \
            && command mv -f "$_plugin_bundle.tmp" "$_plugin_bundle"
    fi

    [[ -s $_plugin_bundle ]] && source "$_plugin_bundle"

    # forgit (deferred) defines ga, gd, glo ... AFTER aliases/git.zsh has loaded.
    # Queue the re-source behind it so YOUR git aliases win, as they do today.
    # Remove this line if you prefer forgit's aliases.
    (( $+functions[zsh-defer] )) && zsh-defer source "$MYDOTS/aliases/git.zsh"
else
    print -u2 "antidote missing: brew install antidote"
fi

unset _plugin_list _plugin_bundle