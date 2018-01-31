#!/bin/bash
#
# what: installs and configures nginx to proxy to our local app server
#
# install the nginx package and setup a link into our vagrant directory
# for the virtual host configuration
sudo apt-get install -y nginx
if [ ! -L /etc/nginx/sites-enabled/10-app.conf ]; then
    sudo ln -s /vagrant/files/app-nginx.conf /etc/nginx/sites-enabled/10-app.conf
fi

# we want this starting on boot
sudo systemctl enable nginx 2>&1
sudo systemctl start nginx 2>&1

