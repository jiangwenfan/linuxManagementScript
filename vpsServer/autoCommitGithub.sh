#/usr/bin/bash
#auto rsync github reposiroty

if [ ! -n "$1" ];
then
	echo "input not null!"
	echo "input a github repository name!"
	echo "example: ./autoCommitGithub.sh /root/item-rsync/test/"
	exit
fi

month=`date|cut -d" " -f2`
day=`date|cut -d" " -f3`

#need auto rsync github repository
cd $1

git add -A
git commit -m "[auto]$month/$day"
git push

