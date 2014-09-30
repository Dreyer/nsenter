# DOCKER-VERSION 1.2.0
#
# Create a container in which to build the latest version of util-linux 
# in order to get the binary nsenter for use with Docker on Ubuntu.
#
# Once built, outside of the container, you'll need to copy the binary to 
# the host filesystem and clean up the Docker container and image.
# 
# sudo docker cp nsenter:/util-linux/nsenter /usr/local/bin/
# sudo docker cp nsenter:/util-linux/bash-completion/nsenter /etc/bash_completion.d/nsenter
# sudo docker rm nsenter
# sudo docker rmi findsuggestions/nsenter
#

# set base image.
FROM ubuntu:14.04

# set the author field of the generated images.
MAINTAINER @Dreyer

# set user to use when running the image.
USER root

# set the working directory.
WORKDIR /

# silent install which uses the default answers for all questions.
RUN export DEBIAN_FRONTEND=noninteractive

# fetch package index.
RUN apt-get update

# http://askubuntu.com/questions/439056/why-there-is-no-nsenter-in-util-linux
RUN apt-get install -qq -y git build-essential libncurses5-dev libslang2-dev gettext zlib1g-dev libselinux1-dev debhelper lsb-release pkg-config po-debconf autoconf automake autopoint libtool

# checkout latest source code.
RUN git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux

# change to directory and compile binary.
WORKDIR /util-linux/
RUN ./autogen.sh
RUN ./configure --without-python --disable-all-programs --enable-nsenter
RUN make
WORKDIR /
