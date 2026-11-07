# External Terminal Apps


alias md="glow"

# aria2c
#alias aria2="aria2c"
#alias aria="aria2c"

# auto command correction
#eval $(thefuck --alias fix)

# use broot instead of tree
# alias tree="broot --tree --color=yes"

# use fd for find
#alias fd='fdfind'

# use fzf with sysctemctl
#alias fsys='fuzzy-sys'


# download mp3 from from url
alias yt-mp3="yt-dlp --embed-metadata --embed-thumbnail --audio-format mp3 --audio-quality 256k --extract-audio"


# Guarded with `_has`, so `ydl` and the nnn alias exist only when the tools are
# installed. yt-dlp is one of your most-used commands.
if _has yt-dlp; then
   alias ydl='yt-dlp'
fi
# if [ "$(_has yt-dlp)" ]; then
#    alias ydl="yt-dlp"
# fi

#if [ "$(_has mpv)" ]; then
#    mpv="mpv --no-audio"
#fi




# xbindkeys with custom path for config file
#alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"

# nnn file editor
# o : open files only on enter
# H : show hidden files

if _has nnn; then
    alias n='nnn -o -H'
fi
# if [ "$(_has nnn)" ]; then
#     alias n='nnn -o -H'
# fi

alias vlc='/Applications/Video/VLC.app/Contents/MacOS/VLC'

alias cz=czkawka_gui
