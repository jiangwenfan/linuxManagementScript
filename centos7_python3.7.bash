#!/usr/bin/bash
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make libffi-devel
#yum -y install epel-release

wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
tar -zxvf Python-3.7.0.tgz
cd Python-3.7.0
./configure prefix=/usr/local/python3 
make && make install
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3

#yum -y install python-pip

clear
echo "python3:"
python3

#echo "yum需要/usr/bin/yum修改：/usr/bin/python-->/usr/bin/python2"
#echo "/usr/libexec/urlgrabber-ext-down修改: /usr/bin/python--->/usr/bin/python2"
