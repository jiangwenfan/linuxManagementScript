#!/bin/bash
#
#version:
#	apache 2.4.16 ; apr 1.5.2 ; pcre 8.37
#	mysql 5.6.26
#	php 5.6.13
#
#run:
#	./c7CompileLAMP.sh

echo -e "编译安装LAMP环境 \n"

echo -e "编译的各版本号为：
httpd version：httpd-2.4.16
apr version：apr-1.5.2
pcre version：pcre-8.37
apr-util version：apr-util-1.5.4
mysql version：mysql-5.6.26
php version：php-5.6.13
"

echo "安装基本所需工具及其依赖"
yum install wget

echo "正在获取编译所需的软件安装包"
#


echo "正在解压到当前目录"


