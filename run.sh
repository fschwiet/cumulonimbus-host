#!/bin/sh

for directory in ./sites/*; do
 
	siteName=$(basename $directory)

  	if [ -d "$directory" ]; then

		cd ./sites/$siteName; 
		./run.sh
  	fi
done
