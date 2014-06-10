#!/bin/sh

for directory in ./sites/*; do
 
  	if [ -d "$directory/current" ]; then

		cd $directory/current; 
		./run.sh
  	fi
done
