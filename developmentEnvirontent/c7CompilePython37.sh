﻿#!/bin/bash
#version 1.0 centos7快速安装python3.7
#1.1会将报错信息导出来作为日志文件。
echo -e "centos7系统快速编译安装python3.7\n"
echo "正在开始安装前的准备"
yum -y install wget gcc > /dev/null && echo "准备完毕，开始安装"
echo "正在安装python3.7需要的依赖"
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel -y > /dev/null && echo "依赖安装完毕！"
echo "正在从python官网下载python3.5的源码包"
#wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz > /dev/null && echo "下载完毕!" 
wget https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz && echo "downlaod ok！"

echo "正在解压python3.7的源码包"
mkdir /usr/local/python37 && tar -zxvf Python-3.7.10.tgz -C /usr/local/python37 > /dev/null  && echo "解压完毕!"

echo "开始编译前的配置"
cd /usr/local/python37/Python-3.7.10/ && ./configure --prefix=/usr/local/python37/python37> /dev/null && echo "配置完成!"
echo "开始编译，预计耗时3分钟"
make -j 2> /dev/null && echo "编译完成!"
echo "开始编译安装"
make install > /dev/null && echo "编译安装完成!"
ln -s /usr/local/bin/python3.5 /usr/bin/python3 && echo "软链接创建完成!"
echo "全部安装完成! " 
python3 -V

