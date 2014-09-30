#!/usr/bin/env bash

GUESTBASH="/home/vagrant/.bashrc"

# setup nsenter and cleanup.
NSENTER=$(docker inspect --format="{{ .Name }}" nsenter 2> /dev/null)
# check to seee if nsenter container exists.
if [ ! -z "$NSENTER" ]; then
    # move files from container to guest.
    sudo docker cp nsenter:/util-linux/nsenter /usr/local/bin/
    sudo docker cp nsenter:/util-linux/bash-completion/nsenter /etc/bash_completion.d/nsenter
    # remove container and image.
    sudo docker rm nsenter
    sudo docker rmi utillinux/nsenter
    #printf "\n$(cat /vagrant/.docker/nsenter/.bashrc)\n" >> $GUESTBASH
    printf "\n$(cat /vagrant/.bashrc)\n" >> $GUESTBASH
fi