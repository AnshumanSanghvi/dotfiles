# aliases/00-defaults.zsh
# ==============================================================================
# Baseline aliases and helpers, a curated port of what Prezto's `utility`, `rsync` and
# `gnu-utility` modules used to provide.
# The "00-" prefix makes it load FIRST in the aliases/*.zsh glob, so every other
# file in this directory overrides it.
# Not ported on purpose: mkdcd, slit, noremoteglob, cpi/lni/mvi/rmi, lm/lc/lu,
# pushdls/popdls, the terminal and spectrum modules, vi-mode, and the diff/make/dut/
# prep/psub/wdiff/zsh-help wrapper functions.
# ==============================================================================

# --- gnu-utility: g-prefixed coreutils under their plain names ---
# FIRST in this file so no alias exists yet when the functions are defined.
# Active only if coreutils is installed (`whence gwhoami`). Aliases still win over
# functions, so your own ls/grep/cp aliases are unaffected.
if (( $+commands[gwhoami] )); then
    for _c in '[' b2sum base32 base64 basename basenc cat chcon chgrp chmod chown chroot \
        cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr \
        factor false fmt fold groups head hostid id install join kill link ln logname ls \
        md5sum mkdir mkfifo mknod mktemp mv nice nl nohup nproc numfmt od paste pathchk \
        pinky pr printenv printf ptx pwd readlink realpath rm rmdir runcon seq sha1sum \
        sha224sum sha256sum sha384sum sha512sum shred shuf sleep sort split stat stdbuf \
        stty sum sync tac tail tee test timeout touch tr true truncate tsort tty uname \
        unexpand uniq unlink uptime users vdir wc who whoami yes find locate oldfind \
        updatedb xargs egrep fgrep getopt grep indent make sed tar time units which; do
        (( $+commands[g$_c] && ! $+builtins[$_c] )) && \
            eval "function $_c { '$commands[g$_c]' \"\$@\" }"
    done
    unset _c
fi

# --- noglob / nocorrect (matters because CORRECT is on) ---
alias find='noglob find' fc='noglob fc' history='noglob history' locate='noglob locate'
alias scp='noglob scp' sftp='noglob sftp' ftp='noglob ftp'
for _c in ack cd cp ebuild gcc gist grep heroku ln man mkdir mv mysql rm; do
    alias "$_c"="nocorrect $_c"
done
unset _c

# --- safe ops: Prezto's default. Delete these two lines if you never wanted them. ---
alias rm='nocorrect rm -i'
alias ln='nocorrect ln -i'

# --- shortcuts ---
alias _='sudo'
alias b='${(z)BROWSER}'
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias p='${(z)PAGER}'
alias o='open'
alias pbc='pbcopy' pbp='pbpaste'
alias type='type -a'
alias diffu='diff --unified'
alias sa='alias | grep -i'
alias po='popd' pu='pushd' d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
alias df='df -kh' du='du -kh'
alias topc='command top -o cpu' topm='command top -o vsize'
alias http-serve='python3 -m http.server'
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
autoload -Uz run-help-{ip,openssl,sudo}

# --- ls variants ---
# Prezto's `ll -Sr` / `ll -tr` are BSD flags; with your eza `ls`, sorting is `-s <field>`.
# Ascending is the default, so size gives largest last and modified gives newest last.
if (( $+commands[eza] )); then
    alias l='ls -1a' lr='ll -R' lk='ll -s size' lt='ll -s modified' sl='ls'
else
    alias l='ls -1A' lr='ll -R' lk='ll -Sr' lt='ll -tr' sl='ls'
fi

# --- rsync helpers ---
# Prezto ran `rsync --version` and `rsync --help` (twice) on EVERY shell start to choose
# options. Here that work happens on first use only.
if (( $+commands[rsync] )); then
    typeset -ga _rsync_opts
    _rsync_init() {
        local help ver
        _rsync_opts=( --verbose --progress --human-readable --compress --archive --hard-links --one-file-system )
        ver=${"$(command rsync --version 2>&1)"[(w)3]}
        if is-at-least 3.1 $ver; then
            help="$(command rsync --help 2>&1)"
            [[ $help == *xattrs* ]] && _rsync_opts+=( --acls --xattrs )
            [[ $OSTYPE == darwin* && $help == *file-flags* ]] && _rsync_opts+=( --crtimes --fileflags --force-change )
        fi
    }
    _rsync_run()          { (( $#_rsync_opts )) || _rsync_init; command rsync "${_rsync_opts[@]}" "$@" }
    rsync-copy()          { _rsync_run "$@" }
    rsync-move()          { _rsync_run --remove-source-files "$@" }
    rsync-update()        { _rsync_run --update "$@" }
    rsync-synchronize()   { _rsync_run --update --delete "$@" }
    (( $+functions[compdef] )) && compdef _rsync rsync-copy rsync-move rsync-update rsync-synchronize
fi

# --- small functions ---
psu()       { ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}" }
find-exec() { find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \; }