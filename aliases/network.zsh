# Network

alias localip="ipconfig getifaddr en0"

alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# check the IPs from which we are getting network traffic
# Guarded with `_has`. No interface name or router address is hard-coded; bandwhich
# picks the interface itself.
if _has bandwhich; then
    alias network='sudo bandwhich --show-dns --total-utilization'
fi
# if [ "$(_has bandwhich)" ]; then
#     alias network='sudo bandwhich --dns-server 192.168.0.1 --interface wlp0s20f3 --show-dns --total-utilization'
# fi

# check all the ports that are currently open / we are listening to
# lsof works on macOS; `netstat -tulpn` is the Linux flag set and BSD netstat rejects it.
alias ports='sudo lsof -iTCP -sTCP:LISTEN -nP'
# alias ports='sudo netstat -tulpn'

# echo my ip
# https, silent output.
alias myip='curl -s https://api.ipify.org; echo'
# alias myip="curl http://ipecho.net/plain; echo"

# netCons:      Show all open TCP/IP sockets
alias netCons='lsof -i'

# lsock:        Display open sockets
alias lsock='sudo lsof -i -P'

# get info for the entered ip address
# The `ipinfo` function is defined in functions/ipinfo (autoloaded).
# function ipinfo()
# {
#   curl ipinfo.io/$1;
#   echo "";
# }









