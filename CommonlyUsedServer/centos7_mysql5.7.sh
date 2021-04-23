#!/bin/bash
yum install yum-utils -y 

rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
yum-config-manager --disable mysql80-community 
yum-config-manager --enable mysql57-community 
yum -y install mysql-community-server mysql-community-client 
systemctl start mysqld

clear

echo "mysql密码："
grep 'temporary password' /var/log/mysqld.log 
