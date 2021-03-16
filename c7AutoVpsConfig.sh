#!/bin/bash
#centos7

yum update -y
yum install epel-release -y

echo "install system tools..."
yum install wget lrzsz gcc htop screen git -y 2>> /root/auto_vps.log

echo "download frp..."
wget https://github.com/fatedier/frp/releases/download/v0.35.1/frp_0.35.1_linux_amd64.tar.gz
tar -zxvf frp_0.35.1_linux_amd64.tar.gz -C /opt/

