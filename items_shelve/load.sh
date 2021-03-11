#这是一个引导主管理脚本的引导脚本。一般放置在可以直接下载http服务器上，或者随身携带。

apt install subversion -y

clear && echo "about 60 second!"

svn checkout  https://github.com/jiangwenfan/simple_script/trunk/linux_script/mainManagerScript

mv mainManagerScript/*  .  #将所有脚本文件移动到父级目录

rm -rf mainManagerScript && bash SimpleServerManagement.sh #删除空目录，启动主管理脚本
