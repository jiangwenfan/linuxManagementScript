#centos7 替换 阿里yum源[复制进去，在执行]
#V1.1版本
#!/bin/bash
echo "清空yum源"
rm -rf /etc/yum.repos.d/*  && echo "clean yum ---> ok"
echo "替换源"
wget http://mirrors.aliyun.com/repo/Centos-7.repo
mv Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo > /dev/null && echo "replace yum ---> ok"
echo "正在清理缓存...."
yum clean all > /dev/null && echo "clean cache --> ok"
echo "正在重新生成缓存...."
yum makecache > /dev/null && echo "makecache cache ---> ok"
echo "升级软件和系统内核"
yum update -y > /dev/null  && echo "update ---> ok"