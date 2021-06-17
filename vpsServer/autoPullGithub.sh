#/usr/bin/bash
#auto pull github reposiroty

if [ ! -n "$1" ];
then
	echo "input not null!"
	echo "input a github repository name!"
	echo "example: ./autoCommitGithub.sh /opt/test/nginx1/html/websiteDataBackup"
	exit
fi


#need auto rsync github repository
cd $1

git pull 

