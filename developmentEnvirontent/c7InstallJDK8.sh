#!/usr/bin/bash
#centos7上一键安装jdk

echo "
获取jdk文件:
1.本地获取(优先)
2.云存储获取
"
if [ ! -f "jdk-8u281-linux-x64.tar.gz" ]
then
    http://cattle.pwall.icu/jdk-8u281-linux-x64.tar.gz
fi

if [ ! -d "/opt/module" ]
then
    mkdir /opt/module #module不存在，创建。
fi
echo "解压配置"
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
