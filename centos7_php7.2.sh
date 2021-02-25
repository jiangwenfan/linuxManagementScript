#!/bin/bash
# install php7.2
yum -y install epel-release
rpm -ivh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install mod_php72w php72w-cli php72w-devel
yum -y install php72w-fpm php72w-common php72w-gd 
yum -y install php72w-mbstring php72w-posix 
yum -y install php72w-dom unzip php72w-pdo
yum -y install php72w-pdo_mysql


clear
php -v
