# rc/options.zsh
# ==============================================================================
# Shell, directory and history options. This file now owns everything Prezto's
# `environment`, `directory`, `history` and (partly) `utility` modules set, because
# those modules are gone. It runs after /etc/zshrc, which is why HISTFILE is set here
# and not in env/xdg.zsh (macOS /etc/zshrc overwrites an exported HISTFILE).
# ==============================================================================

# --- environment (from Prezto `environment`) ---
setopt COMBINING_CHARS        # combine zero-length punctuation (accents)
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
setopt RC_QUOTES              # 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt LONG_LIST_JOBS         # jobs in long format
setopt AUTO_RESUME            # resume an existing job instead of starting a new one
setopt NOTIFY                 # report background job status immediately
unsetopt MAIL_WARNING BG_NICE HUP CHECK_JOBS
unset MAILCHECK

# Disable flow control so Ctrl-S / Ctrl-Q reach the line editor.
[[ -r ${TTY:-} && -w ${TTY:-} ]] && (( $+commands[stty] )) && stty -ixon <$TTY >$TTY

# Quote URLs automatically when typed or pasted.
if [[ $TERM != dumb ]]; then
    autoload -Uz bracketed-paste-url-magic url-quote-magic
    zle -N bracketed-paste bracketed-paste-url-magic
    zle -N self-insert url-quote-magic
fi

# --- directories and globbing (from Prezto `directory`) ---
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
setopt CDABLE_VARS MULTIOS EXTENDED_GLOB NO_CASE_GLOB
unsetopt CLOBBER

# --- correction ---
# Prezto's utility module enabled CORRECT (command names only). CORRECT_ALL asked about
# every argument and stays off.
setopt CORRECT
unsetopt CORRECT_ALL

# --- history (from Prezto `history`, with your location and size) ---
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST EXTENDED_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY HIST_REDUCE_BLANKS
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# --- beeps: all off (HIST_BEEP is separate from BEEP) ---
unsetopt BEEP LIST_BEEP HIST_BEEP