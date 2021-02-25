#v1.1
#!/bin/bash
echo "常用软件自动配置中....."
echo " "
yum -y install wget > /dev/null && echo "wget is ---> ok "
yum -y install vim > /dev/null && echo "vim is ----> ok "
yum -y install net-tools > /dev/null && echo "ipconfig is ---> ok "
yum -y install openssh-server > /dev/null && echo "ssh is --->  ok "
yum -y install curl > /dev/null && echo "curl is ---> ok! "
echo " "