#!/bin/bash
#根据实际情况修改需要执行的命令和Screen的name
#chmod +x /etc/rc.d/rc.local 
#追加此脚本的绝对路径到rc.loal里面。

screenName="ssh-server-frpc" #screen name 
screen -dmS $screenName  

cmd="/root/frp/frpc -c /root/frp/frpc2.ini" #need exec command
screen -x -S $screenName -p 0 -X stuff "$cmd"  
screen -x -S $screenName -p 0 -X stuff $'\n' #只有通过这个回车，才会执行上面这个命令 


