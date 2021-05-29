#!/usr/bin/bash
echo """使用前提:
    2.jdk安装成功
    
    安装包来自内网nginx提供。
"""
sleep 3


echo "config hosts"
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

echo "config python3"
pythonStatus=`python3 -V`
if [ ! -n "${pythonStatus}" ]
then
	wget https://raw.githubusercontent.com/jiangwenfan/linuxManagementScript/main/c7AutoPy3.sh
	chmod +x c7AutoPy3.sh
	./c7AutoPy3.sh
else
	echo "已存在python3 enviration"
fi

echo "config java"
#正在努力之中。。。。。。。


#file not exists,download file from cloud
if [ ! -f "scala-2.11.12.tgz" ]
then
	wget http://sick.pwall.icu:62022/spark/scala-2.11.12.tgz
fi

if [ ! -f "spark-2.3.2-bin-hadoop2.7.gz" ]
then
	wget http://sick.pwall.icu:62022/spark/spark-2.3.2-bin-hadoop2.7.gz
fi

if [ ! -d "/opt/software/spark" ]
then
	mkdir -p /opt/software/spark
fi

echo "解压释放"
tar -zxvf scala-2.11.12.tgz -C /opt/software/spark
tar -zxvf spark-2.3.2-bin-hadoop2.7.gz -C /opt/software/spark

ln -s /opt/software/spark/scala-2.11.12/ /opt/software/spark/scala
ln -s /opt/software/spark/spark-2.3.2-bin-hadoop2.7/ /opt/software/spark/spark

when file not exists,create file
if [ ! -x "~/.bashrc"]
then
    touch ~/.bashrc
fi
cp ~/.bashrc ~/.bashrc.backup
echo '
   export SCALA_HOME=/opt/software/spark/scala
   export PATH=$PATH:$SCALA_HOME/bin

   export SPARK_HOME=/opt/software/spark/spark/
    export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
' >> ~/.bashrc
source ~/.bashrc

clear
echo "验证scala---"
scala -version

echo "spark config----"
sparkBase=/opt/software/spark/spark/conf/
cp $sparkBase/spark-env.sh.template $sparkBase/spark-env.sh
cp $sparkBase/log4j.properties.template $sparkBase/log4j.properties
cp $sparkBase/slaves.template $sparkBase/slaves

hostname=`cat /etc/hostname`
echo  " 
    export JAVA_HOME=$JAVA_HOME
    export SCALA_HOME=$SCALA_HOME
    export SPARK_MASTER_IP=$hostname
    export SPARK_WORKER_MEMORY=1024m
    export SPARK_WORKER_CORES=1
    export SPARK_WORKER_INSTANCES=1 
	

	export PYSPARK_PYTHON=`which python3`
	export PYSPARK_DRIVER_PYTHON=`which python3`
" >> $sparkBase/spark-env.sh
echo $hostname > $sparkBase/slaves 

source ~/.bashrc

/opt/software/spark/spark/sbin/start-all.sh

clear
jps

echo "spark使用: 
	start-all.sh 启动sprak
	stop-all.sh 停止spark
"


