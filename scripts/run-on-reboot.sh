#!/bin/bash

for directory in ./deploys/*; do
   	if [ -d "$directory/current" ]; then
		cd $directory/current; 
		./run.sh
  	fi
done
