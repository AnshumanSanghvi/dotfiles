# rc/options.zsh
# ==============================================================================
# Shell and history options Prezto does not already set. Sourced after Prezto.
# The history FILE location is in .zpreztorc, not here.
# ==============================================================================

# --- history ---
setopt HIST_REDUCE_BLANKS    # remove superfluous blanks before recording an entry

# --- directories and globbing ---
setopt AUTO_CD               # cd by typing a directory name
setopt NO_CASE_GLOB          # case-insensitive globbing

# --- correction ---
# CORRECT_ALL asked "correct 'fs' to 'wfs'?" on every argument. Prezto's CORRECT
# (command names only) stays on.
unsetopt CORRECT_ALL
unset MAILCHECK

# --- beeps ---
# HIST_BEEP is a separate option from BEEP, and Prezto turns it on.
unsetopt beep list_beep hist_beep