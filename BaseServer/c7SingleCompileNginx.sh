#this is a script that is simple compile and install nginx.18.
#default install location :  /opt/test/nginx1

echo "download and base config."
wget http://nginx.org/download/nginx-1.18.0.tar.gz
yum groupinstall "Development Tools" "Basic Web Server" -y
yum install -y gcc gcc-c++ autoconf automake make
yum install zlib zlib-devel openssl openssl-devel pcre pcre-devel wget httpd-tools vim

echo -e "create user"
useradd -r -s /sbin/nologin nginx 

echo -e  "compile and install"
tar -zxvf nginx*.tar.gz
cd nginx-1.18.0

./configure --prefix=/opt/test/nginx1/ --user=nginx --group=nginx --with-http_ssl_module --with-http_flv_module --with-http_gzip_static_module --with-http_stub_status_module --with-threads --with-file-aio

make -j 2
make install

echo -e "set environment of nginx"
echo '
	export PATH="$PATH:/opt/test/nginx1/sbin"
' > /etc/profile.d/nginx.sh

source /etc/profile

nginx -v
