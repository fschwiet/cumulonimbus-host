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
			cd ./sites/$siteName; 
			./run.sh
		fi
  	fi
done
