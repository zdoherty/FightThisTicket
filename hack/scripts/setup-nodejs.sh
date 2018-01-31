#!/bin/bash
#
# what: installs nodejs and the npm package manager
#
# the packages are distributed from an https source, so we'll need that transport
sudo apt-get install -y apt-transport-https

# and they're signed! nice!
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

NODEREPO="node_6.x"
DISTRO="xenial"

echo "deb https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list

# since we're adding new repos, we need to update
sudo apt-get update
sudo apt-get install -y nodejs

