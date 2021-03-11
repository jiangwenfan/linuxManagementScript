#!/usr/bin/bash
echo """使用前提:
    1.ping通主机名
    2.jdk安装成功
    3.memory > 1024M
    4.CPU core >= 1
    5.python3安装成功
"""
#sleep 3

#mkdir -p /opt/software/spark
#
#echo "解压释放"
#tar -zxvf scala-2.11.12.tgz -C /opt/software/spark
#tar -zxvf spark-2.3.2-bin-hadoop2.7.gz -C /opt/software/spark
#
#ln -s /opt/software/spark/scala-2.11.12/ /opt/software/spark/scala
#ln -s /opt/software/spark/spark-2.3.2-bin-hadoop2.7/ /opt/software/spark/spark
#
#when file not exists,create file
#if [ ! -x "~/.bashrc"]
#then
#    touch ~/.bashrc
#fi
#cp ~/.bashrc ~/.bashrc.backup
#echo '
#   export SCALA_HOME=/opt/software/spark/scala
#   export PATH=$PATH:$SCALA_HOME/bin
#
#   export SPARK_HOME=/opt/software/spark/spark/
#    export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
#' >> ~/.bashrc
#source ~/.bashrc
#
#clear
#echo "验证scala---"
#scala -version

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


