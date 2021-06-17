#!/bin/bash

show_info(){
	clear
	echo  -e "ubuntu server manager: \n"
	echo -e "
	1.vsftp
	2.lightftp(easy)
	3.apache
	4.mysql
	5.php
	6.samba
	7.nginx
	8.tomcat

	"
	echo "按q键退出"

	        read -e -p "please input number:" num
case $num in
        1) install_redshift
        ;;
        2) install_chrome
        ;;
        3) install_conky
        ;;
        4) install_wps
        ;;
        5) install_mpv
        ;;
        6) install_flameshot
        ;;
        7) install_kazam
        ;;
        8)
        ;;
        9)
        ;;
        10) ServerManager
        ;;
        q) echo "退出" && exit
        ;;
        *) echo "invalid number"
        ;;
esac

}



main(){
	show_info

}
main
