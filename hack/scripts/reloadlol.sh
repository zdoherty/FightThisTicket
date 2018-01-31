#!/bin/bash
#
# what: constantly watches config files in the least efficient
#       way possible to makes updates a bit easier
#
while : ; do
    # note: vagrant doesn't support inotify on synced directories
    #       so we need to be a bit gross...
    NGINX_MD5SUM=$(md5sum /vagrant/files/app-nginx.conf)

    if [[ $NGINX_MD5SUM != $LAST_NGINX_MD5SUM ]]; then
        # test to make sure the next nginx config is valid before attempting to reload
        #
        # we need to echo the return code (bash will set the return code of the last
        # command to the magic variable $?) and check it to provide some fault tolerance
        RET=$(sudo systemctl restart nginx.service; echo $?)

        if [[ $RET != 0 ]]; then
            echo "nginx restart failed! we'll try again later." >> /vagrant/reloader.log
            echo "$(sudo systemctl status nginx.service)" > /vagrant/nginx-errors
        else
            # this will keep this watcher in a retry loop until the config is fixed
            LAST_NGINX_MD5SUM="$NGINX_MD5SUM"
            rm /vagrant/nginx-errors
        fi
    fi

    sleep 5
done
