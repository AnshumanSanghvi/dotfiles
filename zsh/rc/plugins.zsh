# rc/plugins.zsh
# ==============================================================================
# Antidote: static plugin bundles. Replaces Prezto and zplug.
#
# HOW IT WORKS
#  - A list (plugins.txt) is compiled by `antidote bundle` into ONE plain zsh file.
#  - The bundle is rebuilt only when its list is newer than it, so a normal startup is a
#    single `source`, with no plugin-manager code running.
#  - `antidote` itself is a lazy stub, so its code loads only when you call it
#    (antidote update | list | purge).
#  - There are two lists. This file loads the EARLY one (plugins.txt) before compinit, so
#    compinit sees the completions the plugins ship. rc/plugins-late.zsh loads the LATE
#    one (plugins-late.txt) after compinit, for plugins that must follow it.
# ==============================================================================

# Plugins assume these are autoloaded; Prezto's environment module used to do it.
autoload -Uz add-zsh-hook is-at-least colors && colors

# cros-auto-notify reads these at precmd time. They moved here from the old zplug
# list because that file no longer exists.
export AUTO_NOTIFY_THRESHOLD=20
AUTO_NOTIFY_IGNORE=("docker" "podman" "man" "sleep" "top" "htop" "vim" "less")

# forgit (deferred) builds its aliases from these variables when it loads, so they must
# be set before the bundle. Only the three names that collide with aliases/git.zsh
# (ga, gd, gco) are changed; every other forgit alias keeps its default (glo, gss, ...).
forgit_add=fga
forgit_diff=fgd
forgit_checkout_commit=fgco

if [[ -r $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh ]]; then

    # Lazy stub: the first call loads the real function, then re-dispatches.
    antidote() {
        unfunction antidote
        source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
        antidote "$@"
    }

    # _load_plugin_list NAME: bundle zsh/NAME.txt into $XDG_CACHE_HOME/zsh/NAME.zsh when
    # the bundle is missing or older than the list, then source it. The bundle is written
    # to a temp file first, so an offline failure cannot leave an empty bundle behind.
    # rc/plugins-late.zsh uses it too, then removes it.
    _load_plugin_list() {
        local list="$ZDOTDIR/$1.txt" bundle="$XDG_CACHE_HOME/zsh/$1.zsh"
        if [[ ! -s $bundle || $list -nt $bundle ]]; then
            antidote bundle <"$list" >|"$bundle.tmp" \
                && command mv -f "$bundle.tmp" "$bundle"
        fi
        [[ -s $bundle ]] && source "$bundle"
    }

    _load_plugin_list plugins
else
    print -u2 "antidote missing: brew install antidote"
fi
