#!/bin/bash
#
# what: prepares the server for normal use
#
# we'll probably need some packages at some point, updating the
# package list now saves us some headache later, but takes time,
# so we'll only do it initially and every 2 hours at most.
if [ ! -f /root/.recently-updated ]; then
    sudo apt-get update
    touch /root/.recently-updated -d '+2 hour'
else
    # compare the timestamp of the recently-updated file with the
    # current time to see if we should update
    if [[ $(stat -c %Y /root/.recently-updated) -lt $(date +%s) ]]; then
        sudo apt-get update
        # leave a marker of when to update next
        touch /root/.recently-updated -d '+2 hour'
    fi
fi

# since we're running ubuntu and don't need their snap runtime,
# we might as well disable it
sudo systemctl disable snapd 2>/dev/null
sudo systemctl stop snapd 2>/dev/null

# same thing for lxc
sudo systemctl disable lxcfs 2>/dev/null
sudo systemctl stop lxcfs 2>/dev/null

# set the date!
sudo timedatectl set-ntp true

# give the server a reasonable name
sudo hostnamectl set-hostname fight-this-ticket

# setup the hosts file to agree with the above
cat <<EOF | sudo tee /etc/hosts
127.0.0.1   localhost   fight-this-ticket   fight-this-ticket.vagrant.internal
EOF

