#!/bin/bash
#version 1.0

echo "mwget is atuo install" && echo

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

