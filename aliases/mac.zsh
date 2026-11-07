# MacOS Specific Aliases

# Speed-up Terminal load time by clearing system logs
# `speedup` is gone: Apple Software Logging (/private/var/log/asl) was retired in
# macOS 10.12, so clearing it never sped up startup.
# alias speedup="sudo rm -rf /private/var/log/asl/*"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
# alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; speedup"
# Single definition, without the obsolete /private/var/log/asl cleanup.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

## preview file from terminal in quicklook (Mac only)
alias ql="qlmanage -p 2>/dev/null"

# System state
#alias reboot="sudo /sbin/reboot"
#alias poweroff="sudo /sbin/poweroff"
#alias halt="sudo /sbin/halt"
#alias shutdown="sudo /sbin/shutdown"
#alias flighton='sudo rfkill block all'
#alias flightoff='sudo rfkill unblock all'
#alias snr='sudo service network-manager restart'


# open man page in Preview.app (Mac only)
# The `pman` function is defined in functions/pman (autoloaded).
# pman () {
#     man -t "${1}" | open -f -a /System/Applications/Preview.app
# }

# macOS-like open command for linux
#if ! _has open && _has xdg-open; then
#  alias open=xdg-open
#fi

# open argument in finder
alias f='open -a Finder'

# A function with `&&` between the brew steps, so a failed update does not run upgrade
# or cleanup. softwareupdate runs first.
update() {
  sudo softwareupdate -i -a
  brew update && brew upgrade && brew cleanup
}
# alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup;'

