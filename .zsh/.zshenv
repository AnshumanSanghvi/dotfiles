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
. "$HOME/.cargo/env"


# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
XDG_DATA_HOME="$HOME/.local/share"
XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/usr/local/share/:/usr/share/:/usr/share/ubuntu:/var/lib/flatpak/exports/share:/var/lib/snapd/desktop"
XDG_CONFIG_HOME="$HOME/.config"
XDG_STATE_HOME="$HOME/.local/state"
XDG_CONFIG_DIRS="/etc/xdg"
XDG_CACHE_HOME="$HOME/.cache"
