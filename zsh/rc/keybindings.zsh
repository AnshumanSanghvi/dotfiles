# rc/keybindings.zsh
# ==============================================================================
# Emacs key bindings (port of Prezto's `editor` module, emacs half only) and the
# history-substring-search bindings. Sourced after the plugin bundle, so the widgets
# from history-substring-search already exist.
# ==============================================================================

# REQUIRED: VISUAL=vim contains "vi", so zsh would otherwise select the vi keymap.
bindkey -e

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

autoload -Uz edit-command-line
zle -N edit-command-line

# "...." -> "../.."
expand-dot-to-parent-directory-path() {
    if [[ $LBUFFER = *.. ]]; then LBUFFER+='/..'; else LBUFFER+='.'; fi
}
zle -N expand-dot-to-parent-directory-path

# Alt-; toggles a leading # (comment the line out / back in).
pound-toggle() {
    if [[ $BUFFER = '#'* ]]; then
        (( CURSOR != $#BUFFER )) && (( CURSOR -= 1 ))
        BUFFER="${BUFFER:1}"
    else
        BUFFER="#$BUFFER"; (( CURSOR += 1 ))
    fi
}
zle -N pound-toggle

# --- words ---
# Sequences cover Terminal.app, iTerm2 and application-mode terminals.
for k in '\eb' '\eB' '\e[1;5D' '\e[5D' '\e\e[D' '\eOd'; do bindkey -M emacs "$k" emacs-backward-word; done
for k in '\ef' '\eF' '\e[1;5C' '\e[5C' '\e\e[C' '\eOc'; do bindkey -M emacs "$k" emacs-forward-word; done
for k in '\ek' '\eK'; do bindkey -M emacs "$k" backward-kill-line; done

# --- line editing ---
# Home and End (not Ctrl-A/E), your existing choice, with the application-mode variants.
for k in '\e[H' '\eOH' '\e[1~'; do bindkey -M emacs "$k" beginning-of-line; done
for k in '\e[F' '\eOF' '\e[4~'; do bindkey -M emacs "$k" end-of-line; done
bindkey -M emacs '\e[3~' delete-char
bindkey -M emacs '\e[2~' overwrite-mode
bindkey -M emacs '^?'    backward-delete-char
bindkey -M emacs ' '     magic-space
bindkey -M emacs '^L'    clear-screen
bindkey -M emacs '\e[Z'  reverse-menu-complete
for k in '\ee' '\eE'; do bindkey -M emacs "$k" expand-cmd-path; done
for k in '\em' '\eM'; do bindkey -M emacs "$k" copy-prev-shell-word; done
for k in '^Q' '\eq' '\eQ'; do bindkey -M emacs "$k" push-line-or-edit; done
bindkey -M emacs '\e_'   redo
bindkey -M emacs '^X^B'  vi-find-prev-char
bindkey -M emacs '^X^]'  vi-match-bracket
bindkey -M emacs '^X^E'  edit-command-line
bindkey -M emacs '\e;'   pound-toggle

# Pattern search in incremental search (fzf rebinds ^R later in lazy.zsh, as before).
if (( $+widgets[history-incremental-pattern-search-backward] )); then
    bindkey -M emacs '^R' history-incremental-pattern-search-backward
    bindkey -M emacs '^S' history-incremental-pattern-search-forward
fi

# Dot expansion, also inside incremental search.
bindkey -M emacs '.' expand-dot-to-parent-directory-path
bindkey -M isearch '.' self-insert 2>/dev/null

# --- history-substring-search ---
# Your values, assigned AFTER the plugin loaded (it reads them at use time).
# Empty globbing flags = case-sensitive search; empty colours = no highlight.
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS=''
if (( $+widgets[history-substring-search-up] )); then
    for k in '^P' '\e[A' '\eOA'; do bindkey -M emacs "$k" history-substring-search-up; done
    for k in '^N' '\e[B' '\eOB'; do bindkey -M emacs "$k" history-substring-search-down; done
fi
unset k

# --- OMZ sudo plugin, vendored unchanged: double-tap ESC prepends sudo ---
[[ -r $ZDOTDIR/rc/sudo.zsh ]] && source "$ZDOTDIR/rc/sudo.zsh"