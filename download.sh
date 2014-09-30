 #!/usr/bin/env bash

AUTHOR="dreyer"
VERSION="2.25.213-286f1"
NSENTER="nsenter-$VERSION"
wget "https://github.com/$AUTHOR/nsenter/releases/download/$VERSION/nsenter.tar.gz" -O nsenter.tar.gz
tar -xzf nsenter.tar.gz
rm nsenter.tar.gz
cp "$NSENTER/bin/nsenter" /usr/local/bin/
cp -r "$NSENTER/bash_completion.d/nsenter" /etc/bash_completion.d/nsenter
rm -rf $NSENTER