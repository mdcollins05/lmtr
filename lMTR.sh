#!/bin/bash

#Thanks to https://github.com/marascio/bash-tips-and-tricks/tree/master/showing-progress-with-a-bash-spinner for this lovely bit of code!
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    echo "$pid" > "/tmp/.spinner.pid"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
#    printf "    \b\b\b\b"
}


while :
do
  (mtr -rw -c 100 "$@" 2>&1> ./mtr/`date +%Y%m%d-%H%M%S`) &
  spinner $!
done
