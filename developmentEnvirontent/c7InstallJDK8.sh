#!/usr/bin/bash
#install jdk of oracle on centos7

echo "download file from qiniu.com"
if [ ! -f "jdk-8u281-linux-x64.tar.gz" ]
then
    wget http://cattle.pwall.icu/jdk-8u281-linux-x64.tar.gz
fi

if [ ! -d "/opt/module" ]
then
    mkdir /opt/module #module not exists,create directory。
fi
echo "unzip"
#tar -zxvf jdk-8u281-linux-x64.tar.gz -C /opt/module
ln -s /opt/module/jdk1.8.0_281  /opt/module/jdk
echo '
export JAVA_HOME=/opt/module/jdk
export CLASS_HOME=$JAVA_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin
' >> ~/.bashrc

source ~/.bashrc

clear
java

javac

javadoc

echo "出现environment不生效问题，重新进入bash"
