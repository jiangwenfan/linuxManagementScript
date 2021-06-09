#!/bin/bash

wget http://nginx.org/download/nginx-1.18.0.tar.gz
tar -zxvf nginx*.tar.gz && cd nginx*

./configure --prefix=/opt/module/nginx --user=nginx --group=nginx --with-http_ssl_module --with-http_flv_module --with-http_gzip_static_module --with-http_stub_status_module --with-threads --with-file-aio
#default install "/opt/module/nginx"

make -j 2 && make install
