echo -e "安装mysql5.7\n"
echo -e "安装含有mysql5.7的yum源头\n"
rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm 
echo -e "关闭yum源中的80包，开启57包\n"
yum-config-manager --disable mysql80-community  
yum-config-manager --enable mysql57-community  
echo -e "开始安装服务端和客户端\n"
yum -y install mysql-community-server mysql-community-client 
echo -e "开启mysql服务\n"
systemctl start mysqld
echo -e "mysql服务设置为开启启动\n"
systemctl enable mysqld

echo -e "查看mysql默认密码\n"
grep 'temporary password' /var/log/mysqld.log 
#if mysqld.log no logs,没有日志，查看不到密码；或者查看到的密码无法登录MySQL:
#解决办法：
#vim /etc/my.cnf  ----> skip_grant_tables
#systemctl restart mysqld
#mysqll -uroot -p #空密码登录
#----->update mysql.user set authentication_string=password('123456') where user='root' ;
#flush privileges;

#在/etc/my.cnf种删掉skip_grant_tables;重启服务
#mysql -uroot -p #设置的密码登录
#### 报错解决: 
#---------------->  set global validate_password_policy=0;
#		    set global validate_password_length=1;



sleep 5
echo -e "取消密码复杂度设置\n"
set global validate_password_policy=0;
set global validate_password_mixed_case_count=0;
set global validate_password_number_count=3;
set global validate_password_special_char_count=0;
set global validate_password_length=3;	

echo -e "\n设置mysql密码:

set password for root@localhost=password("admin123KK@@"); 
flush privileges;
"


#senior set: ----> set remote login:
#select host,user from mysql.user;
#update mysql.user set host='%' where user='root'
#flush privileges;

#systemctl restart mysqld

