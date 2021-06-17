#!/bin/bash
screenName="host-ssh-server-frpc" #screen name 
screen -dmS $screenName  

cmd="/root/frp/frpc -c /root/frp/frpc.ini" #need exec command
screen -x -S $screenName -p 0 -X stuff "$cmd"  
screen -x -S $screenName -p 0 -X stuff $'\n' #只有通过这个回车，才会执行上面这个命令 


