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


name_of_site=${1:?"The first parameter indicating what site to deploy was missing."}
commit_to_deploy=${2:-"master"}

if is_git_unclean .
then
	echo "There are uncommitted changes in cumulonimbus-host."
	exit
fi

src_to_deploy=./sites/$name_of_site

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

if ! [ -d ./deploys ] 
then
	mkdir ./deploys
fi

if ! [ -d ./deploys/$name_of_site ] 
then
	mkdir ./deploys/$name_of_site
fi

commit_id=$(git --git-dir $src_to_deploy/.git rev-parse master)
dir_index=0

while [ -d ./deploys/$name_of_site/${commit_id}_${dir_index} ]
do
	((dir_index++))
done

deploy_target=./deploys/$name_of_site/${commit_id}_${dir_index}

mkdir $deploy_target
git --git-dir $src_to_deploy/.git archive --format=tar $commit_to_deploy | tar --extract -C $deploy_target

pushd $deploy_target > /dev/null

if ! ./prerun.sh
then
	popd > /dev/null
	echo "Failure running $deploy_target/prerun.sh"
	exit 1
fi

popd > /dev/null

if ! ln -s "$deploy_target" ./deploys/$name_of_site/current
then
	echo "Unable to create symbolic link."
	exit
fi

pushd ./deploys/$name_of_site/current > /dev/null

if ! $deploy_target/run.sh
then
	popd > /dev/null
	echo "Failure running $deploy_target/run.sh"
	exit 1
fi

