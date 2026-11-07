# docker aliases

# CHANGED: delete `dkstarts` and `dkstops`. They run `sudo service docker ...`, which does
# not exist on macOS (OrbStack/Rancher Desktop/Colima manage the engine).


# start docker service
# alias dkstarts='sudo service docker start'

# stop docker service
# alias dkstops='sudo service docker stop'

# stop all containers
alias dkstopall='docker stop $(docker ps -q)'

# List all containers by status using custom format
alias dkpsa='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'

# Removes a container, it requires the container name \ ID as parameter
alias dkrm='docker rm -f'

# Removes an image, it requires the image name \ ID as parameter
alias dkrmi='docker rmi'

# Lists all images by repository sorted by tag name
alias dkimg='docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" | sort'

# Lists all persistent volumes
alias dkvlm='docker volume ls'

# Diplays a container log, it requires the image name \ ID as parameter
alias dklgs='docker logs'

# Streams a container log, it requires the image name \ ID as parameter
alias dklgsf='docker logs -f'

# Initiates a session withing a container, it requires the image name \ ID as parameter followed by the word "bash"
alias dkterm='docker exec -it'

# Starts a container, it requires the image name \ ID as parameter
alias dkstrt='docker start'

# Stops a container, it requires the image name \ ID as parameter
# CHANGED: delete the duplicate `alias dkstp=` line; `dkstop` is kept.
#alias dkstp='docker stop'
alias dkstop='docker stop'



# view logs of a docker container by name
# CHANGED: the old version grepped `docker ps` output; the name filter is exact and
# survives unusual formatting.
dkln() {
  docker logs -f $(docker ps -q -f name="$1")
}
# dkln() {
#   docker logs -f `docker ps | grep $1 | awk '{print $1}'`
# }

# CHANGED: `docker rm` with no exited containers printed an error, and the volume line
# listed volumes by hand. The prune commands do the same job and handle empty sets.
dkclean() {
  docker container prune -f
  docker volume prune -f
}

# dkclean() {
#   docker rm $(docker ps --all -q -f status=exited)
#   docker volume rm $(docker volume ls -qf dangling=true)
# }

# CHANGED: dropped -f so Docker asks for confirmation before deleting every unused image.
dkprune() {
  docker system prune -a
}
# dkprune() {
#   docker system prune -af
# }

# display memory, cpu, network i/o and block i/o for running containers
dktop() {
  docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
}

# if container name is supplied, display its stats otherwise display all stats
dkstats() {
  if [ $# -eq 0 ]
    then docker stats --no-stream;
    else docker stats --no-stream | grep $1;
  fi
}

# enter terminal of given container id
dke() {
  docker exec -it $1 /bin/sh
}

dkexe() {
  docker exec -it $1 $2
}

# CHANGED: the old version quit an app named "Docker" and called `countdown`, which is not
# defined anywhere in your dotfiles. You use OrbStack, so restart its engine instead.
# VERIFY the subcommand with: orbctl --help
dkreboot() {
  if _has orbctl; then
    orbctl restart docker
  else
    echo "dkreboot: orbctl not found" >&2
    return 1
  fi
}
# dkreboot() {
#   osascript -e 'quit app "Docker"'
#   countdown 2
#   open -a Docker
#   echo "Restarting Docker engine"
#   countdown 120
# }

dkstate() {
  docker inspect $1 | jq '.[0].State'
}
# dockerized applications: apps which are aliases to run from their docker containers

## pgloader via docker
alias pgloader="docker run --rm --name pgloader dimitri/pgloader:latest pgloader"

# use lzdock as a htop like command for docker containers
#alias lzdock='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker/ lazyteam/lazydocker'