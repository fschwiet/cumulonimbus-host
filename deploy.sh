#!/bin/sh

function is_git_empty {
	
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


echo "host: $(is_git_empty 'c:/src/cumulonimbus-host')"
echo "host: $(is_git_empty 'c:/src/cumulonimbus-host/sites/cumulonimbus-project')"
