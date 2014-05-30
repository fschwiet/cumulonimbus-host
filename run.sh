#!/bin/sh

for directory in ./sites/*; do
 
	siteName=$(basename $directory)

  	if [ -d "$directory" ]; then
    	echo $siteName

        # how will directory switching happen?
        #  maybe pm2 runs a shell expression "cd /link; ./run.sh"

    	# start testing in a vagrant VM with node / pm2

    	if [ $(ps -e -o cmd | grep pm2 | grep $siteName | grep -v grep | wc -l | tr -s "\n") -eq 0 ]
		then
		echo "lol"
			cd ./sites/$siteName/src; 
			pwd;
			pm2 start ./run.sh --name $siteName --user wwwuser --interpreter bash
		fi
  	fi
done


# note:  limited environment variables available within this crontab script.
#   In particular, $PATH is not set.

#if [ $(ps -e -o cmd | grep pm2 | grep hello-server | grep -v grep | wc -l | tr -s "\n") -eq 0 ]
#then
#	cd /sites/www; /usr/local/bin/pm2 start hello-server.js --user wwwuser
#fi
