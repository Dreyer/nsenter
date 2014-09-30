#!/usr/bin/env bash

NSENTER=$(which nsenter)

if [ -z "$NSENTER" ]; then
    echo "Couldn't find nsenter."
    exit 1
fi

VERSION=$($NSENTER --version | sed -r "s/nsenter\sfrom\sutil-linux\s//")
RELEASES="/vagrant/releases"
RELEASEDIR="$RELEASES/$VERSION"
RELEASEBIN="$RELEASEDIR/bin"
RELEASEETC="$RELEASEDIR/bash_completion.d"
RELEASEZIP="$RELEASES/nsenter-$VERSION.tar.gz"

# clean previous packages.
if [ -f "$RELEASEZIP" ]; then
    rm $RELEASEZIP
fi
if [ -d "$RELEASEDIR" ]; then 
    rm -rf $RELEASEDIR
fi

# setup directories.
mkdir $RELEASEDIR
mkdir $RELEASEBIN
mkdir $RELEASEETC

# move in files from host.
cp /usr/local/bin/nsenter $RELEASEBIN
cp -r /etc/bash_completion.d/nsenter $RELEASEETC

# move to the directory and compress.
cd $RELEASES && tar -czf $RELEASEZIP $VERSION

# remove directory.
rm -rf $RELEASEDIR