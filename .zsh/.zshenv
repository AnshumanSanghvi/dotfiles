# zsh env file
#
# zshenv is sourced on all invocations of the shell, unless the -f option is set.
#
# What goes in it:
#    Set up the command search path
#    Other important environment variables
#    Commands to set up aliases and functions that are needed for other scripts
#
# What does NOT go in it:
#    Commands that produce output
#    Anything that assumes the shell is attached to a tty


ZDOTDIR=~/.zsh

export TERM=xterm-256color # True Color support in terminals and TUI programs that support it (e.g. vim)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unsetopt beep               # don't bloody beep
unsetopt list_beep          # don't beep on ambiguous completions
typeset -U PATH             # remove duplicate paths
