#!/usr/bin/bash
#centos7上一键安装jdk

echo "
获取jdk文件:
1.本地获取
2.云存储获取(暂时未开启)
"
if [ ! -d "/opt/module" ]
then
    mkdir /opt/module #module不存在，创建。
fi
echo "解压配置"
tar -zxvf xxx.tar.gz -C /opt/module
ln -s java----- jdk
echo "
JAVA_HOME=/opt/module/jdk
CLASS_HOME=$JAVA_HOME/lib
PATH=$PATH:$JAVA_HOME/bin
" >> ~/.bashrc
source ~/.bashrc

clear
java
slepp 1.5

clear
javac
slepep 1.5

clear
javadoc
sleep 1.5
