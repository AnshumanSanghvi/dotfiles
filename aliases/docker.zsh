# docker aliases

# There is no `dkstarts`/`dkstops`: `sudo service docker ...` does not exist on macOS
# (OrbStack/Rancher Desktop/Colima manage the engine).


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
# `dkstop` is the stop alias; there is no duplicate `dkstp`.
#alias dkstp='docker stop'
alias dkstop='docker stop'



# view logs of a docker container by name
# Filters by container name instead of grepping `docker ps` output, which survives
# unusual formatting.
dkln() {
  docker logs -f $(docker ps -q -f name="$1")
}
# dkln() {
#   docker logs -f `docker ps | grep $1 | awk '{print $1}'`
# }

# The prune commands handle empty sets (plain `docker rm` errors when no containers have
# exited) and cover volumes without listing them by hand.
dkclean() {
  docker container prune -f
  docker volume prune -f
}

# dkclean() {
#   docker rm $(docker ps --all -q -f status=exited)
#   docker volume rm $(docker volume ls -qf dangling=true)
# }

# No -f, so Docker asks for confirmation before deleting every unused image.
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

# Restarts the OrbStack engine. The subcommand can be checked with: orbctl --help
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