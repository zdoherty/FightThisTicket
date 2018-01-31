#!/bin/bash
#
# what: setup a redis cache
#
# first, we'll need the package! we're going to leave it unconfigured,
# since the defaults are pretty solid. it'll be listening on port 6379
sudo apt-get install -y redis-server redis-tools

sudo systemctl enable redis-server 2>&1
sudo systemctl start redis-server 2>&1

