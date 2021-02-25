#!/bin/bash
#version 1.0

echo "mwget is atuo install" && echo

if [ $# == 1 ];
then
	if [ $1 == c7 ];
	then
		echo "centos7 mwget log:" >> error.log
        	yum install bzip2 gcc gcc-c++ openssl-devel intltool wget -y 2>> error.log
        	cd /usr/local/src 2>> error.log
        	wget http://jaist.dl.sourceforge.net/project/kmphpfm/mwget/0.1/mwget_0.1.0.orig.tar.bz2 2>> error.log
                tar -xjvf mwget_0.1.0.orig.tar.bz2 2>> error.log
                cd mwget_0.1.0.orig 2>> error.log
                ./configure 2>> error.log
                make 2>> error.log
                make install 2>> error.log
                clear 
                mwget 
	elif [ $1 == u18 ];
	then
		echo "u18 install.." 
	else
		echo "the parameter is invalid"
	fi
else
	echo "use the format:
		./mwget_install.sh [system] 
		system: c7 u18
	"
fi

