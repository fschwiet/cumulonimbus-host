#!/bin/bash

function is_git_unclean {

	git_directory=${1:?"is_git_unclean expected parameter"}
	
	pushd  $git_directory > /dev/null
	
	if [ -d .git ];
	then
		change_count=$(git status --porcelain | wc -l)
		popd > /dev/null

		if [ "$change_count" -gt 0 ] 
		then
			true
		else
			false
		fi
	else
		true
	fi
}


echo ${1:?"The first parameter indicating what site to deploy was missing."} > /dev/null

if is_git_unclean .
then
	echo "There are uncommitted changes in cumulonimbus-host."
	exit
fi

src_to_deploy=./sites/$1

if ! [ -d $src_to_deploy ]
then
	echo "Unable to find site to deploy at $src_to_deploy"
	exit 1
fi

if is_git_unclean $src_to_deploy
then
	echo "There are uncommitted changes in $src_to_deploy."
	exit 1
fi


if ! [ -s $src_to_deploy/prerun.sh ]
then
	echo "Expected to find file $src_to_deploy/prerun.sh"
	exit 1
fi

if ! [ -s $src_to_deploy/run.sh ]
then
	echo "Expected to find file $src_to_deploy/run.sh"
	exit 1
fi
