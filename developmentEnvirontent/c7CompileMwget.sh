#!/bin/bash
#compile install mwget on centos7

echo "download ... "
yum install bzip2 gcc gcc-c++ openssl-devel intltool wget -y 2>> error.log

if [ ! -d /opt/software/src ]
then
	mkdir -p /opt/software/src 
fi

cd /opt/software/src/

if [ ! -f  mwget_0.1.0.orig.tar.bz2 ]
then
	wget http://jaist.dl.sourceforge.net/project/kmphpfm/mwget/0.1/mwget_0.1.0.orig.tar.bz2 2>> error.log
fi

echo "unzip"
tar -xjvf mwget_0.1.0.orig.tar.bz2 2>> error.log

echo "install ..."
cd mwget_0.1.0.orig 2>> error.log
./configure 2>> error.log
make -j 2 2>> error.log
make install 2>> error.log
clear 
mwget 

