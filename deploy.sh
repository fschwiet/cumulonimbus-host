#!/bin/bash

function is_git_unclean {
	
	git_directory=$1

	pushd  $git_directory > /dev/null

	if [ -d .git ];
	then
		git_status=$(git status --porcelain) > /dev/null
		popd > /dev/null

		if [ ${git_status:+1} ];
		then
			echo;
		else
		  	echo "changes found in $git_directory"
		fi
	else
		echo "git repository not found in $git_directory"
	fi
}

echo ${1:?"The first parameter indicating what site to deploy was missing."} > /dev/null

if $(is_git_unclean .)
then
	echo "There are uncommitted changes in cumulonimbus-host."
	exit
fi
