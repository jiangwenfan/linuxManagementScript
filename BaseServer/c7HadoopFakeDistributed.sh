#!/bin/bash
#适用于centos7的一键配置hadoop伪分布式
#

echo -e "\n需要安装好jdk\n"
sleep 5

#echo "ssh密钥登录"
#ssh-keygen -t rsa -b 2048
#ssh-copy-id 127.0.0.1 
#systemctl restart sshd


echo -e "\n 1.config hosts..."
hostname=`hostname`
ip=`cat /etc/hosts |grep ${hostname} |grep 127.0.0.1 |cut -d" " -f 1`
hostname=`cat /etc/hosts |grep ${hostname} |grep 127.0.0.1 |cut -d" " -f 2`
#已经存在，则不添加，否则添加。
if [ ! -n "$ip" ]
then
        hostname=`hostname`
        echo "127.0.0.1 ${hostname}" >> /etc/hosts
else
        echo "已存在"
fi
ping $hostname -c 5


echo -e "\n 2.stop firewalld..."
firewalldStatus=`systemctl status firewalld | grep Active|cut -d":" -f2|cut -d"(" -f 1`
if [ $firewalldStatus == "inactive" ]
then
	echo "firewalld已经关闭" 
	isEnabled=`systemctl is-enabled firewalld`
	if [ ${isEnabled} == 'disabled' ]
	then
		echo "开机启动已经关闭"
	else
		systemctl disable firewalld
		echo "开机启动关闭成功..."
	fi
else	
	systemctl stop firewalld #stop firewalld
	echo "关闭成功...."	
	isEnabled=`systemctl is-enabled firewalld`
	if [ ${isEnabled} == 'disabled' ]
	then
		echo "开机启动已经关闭"
	else
		systemctl disable firewalld
		echo "开机启动关闭成功..."
	fi
fi
iptables -F

echo -e "\n 3.selinux config...\n"
selinuxStatus=`getenforce`
if [ ${selinuxStatus} == "Disabled" ]
then
	echo "seliux已关闭"
else
	setenforce 0
	echo "临时关闭成功...."
	selinuxFileStatus=`cat /etc/selinux/config |grep SELINUX= |grep -v '#'|cut -d"=" -f 2`
	if [ ${selinuxFileStatus} == "disabled" ]
	then
		echo "selinux已经被永久关闭"
	else
		getLineNumber=`grep -n "SELINUX=" /etc/selinux/config | grep -v "#" |cut -d":" -f1`	
		getCurrentConfig=`grep -n "SELINUX=" /etc/selinux/config | grep -v "#" |cut -d"=" -f2`
		sed -i "${getLineNumber}s/${getCurrentConfig}/disabled/" /etc/selinux/config
		echo "永久关闭成功，需要重启生效"
	fi
	
fi


#echo "config jdk"
#判断jdk安装，成功不安装。正在努力中。。。
#wget https://raw.githubusercontent.com/jiangwenfan/linuxManagementScript/main/c7AutoInstallJDK8.sh
#chmod +x c7AutoInstallJDK8.sh
#./c7AutoInstallJDK8.sh

echo -e "\nisntall hadoop2.9....\n"
echo -e "\n
获取hadoop安装包:
1.本地获取
2.云端获取(内网nginx提供下载)
\n"
#默认使用本地，如果不存在，云端下载
if [ ! -f "hadoop-2.9.2.tar.gz" ]
then
	wget http://sick.pwall.icu:62022/hadoop-2.9.2.tar.gz
fi

if [ ! -d "/opt/module" ]
then
	mkdir /opt/module
fi
tar -zxvf hadoop-2.9.2.tar.gz -C /opt/module/
ln -s /opt/module/hadoop-2.9.2 /opt/module/hadoop

echo '
export HADOOP_HOME=/opt/module/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
' >> ~/.bashrc

source ~/.bashrc

hadoopBase=/opt/module/hadoop/
echo -e "\nhadoop config\n"
echo '
export JAVA_HOME=$JAVA_HOME
' >>  ${hadoopBase}etc/hadoop/hadoop-env.sh

echo -e "\nconfig core-site.xml ...\n"
hostname=`hostname`
baseLineNum=`grep -n '<configuration>' /opt/module/hadoop/etc/hadoop/core-site.xml|cut -d":" -f1`
#echo $baseLineNum
sed -i "${baseLineNum}a <property>" ${hadoopBase}etc/hadoop/core-site.xml

newLineNum=$((baseLineNum+1))
sed -i "${newLineNum}a <name>fs.defaultFS</name>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a <value>hdfs://${hostname}:9000</value>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a </property>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

#config 2---------
newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a <property>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a <name>hadoop.tmp.dir</name>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a <value>${hadoopBase}data/tmp</value>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a </property>" ${hadoopBase}etc/hadoop/core-site.xml
#echo $newLineNum

#cat ${hadoopBase}etc/hadoop/core-site.xml
#isleep 30

echo -e "\nconfig hdfs-site...\n"
baseLineNum=`grep -n '<configuration>' /opt/module/hadoop/etc/hadoop/hdfs-site.xml|cut -d":" -f1`
#echo $baseLineNum
sed -i "${baseLineNum}a <property>" ${hadoopBase}etc/hadoop/hdfs-site.xml
newLineNum=$((baseLineNum+1))
sed -i "${newLineNum}a <name>dfs.replication</name>" ${hadoopBase}etc/hadoop/hdfs-site.xml
#echo $newLineNum
newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a <value>1</value>" ${hadoopBase}etc/hadoop/hdfs-site.xml
#echo $newLineNum
newLineNum=$((newLineNum+1))
sed -i "${newLineNum}a </property>" ${hadoopBase}etc/hadoop/hdfs-site.xml
#echo $newLineNum
#sleep 18

#cat ${hadoopBase}etc/hadoop/hdfs-site.xml
#sleep 30

echo -e "\n启动hadoop\n"
hdfs namenode -format
sleep 3
hadoop-daemon.sh start namenode
hadoop-daemon.sh start datanode

clear
echo -e "\nstatus:"
jps
sleep 1

#echo "config yarn"
#echo "config mapreduce"
#echo "log server"
