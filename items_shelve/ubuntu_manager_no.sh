#!/bin/bash

initialize(){
	apt install gcc whois git wget tree curl axel vim  subversion snap zip unzip alien -y #初始化 svn
	mkdir /work/software/ && cd /work/software/  
}
install_redshift(){
	apt install redshift redshift-gtk -y
	redshift & 
}
install_chrome(){
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i google*.deb
}
install_flameshot(){
	apt install flameshot -y 
}
install_kazam(){
	apt install kazam -y
}
install_mpv(){
	apt install mpv -y || apt install smplayer -y
}
install_wps(){
	axel https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/9080/wps-office_11.1.0.9080_amd64.deb || wget https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/9080/wps-office_11.1.0.9080_amd64.deb
	dpkg -i wps*.deb
}
install_vmware15(){
	#官网下载太慢,no
	axel  https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-15.5.1-15018445.x86_64.bundle || wget  https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-15.5.1-15018445.x86_64.bundle
	chmod 777 VMware*.bundle
	

}
install_conky(){
	apt-get install conky-all -y
	svn checkout https://github.com/jiangwenfan/simple_script/trunk/linux_script/resource
	cat resource/conkyrc.txt > ~/.conkyrc 
       	conky &
}
install_evernote(){
	axel https://nchc.dl.sourceforge.net/project/nevernote/NixNote2%20-%202.0/Linux/Qt5/nixnote2-2.0_amd64.deb || wget https://nchc.dl.sourceforge.net/project/nevernote/NixNote2%20-%202.0/Linux/Qt5/nixnote2-2.0_amd64.deb
	echo "
	#new add
	deb http://cz.archive.ubuntu.com/ubuntu xenial main
	" >> /etc/apt/source.list
	apt update && apt install libpng12-0 -y || apt install -f -y && apt install libpng12-0 -y
	apt install libtbb2 -y || apt install -f -y && apt install libtbb2 -y
	apt install libcurl3 -y || apt install -f -y && apt install libcurl3 -y
	dpkg -i  nixnote*.deb || echo "未知错误"

}
install_SitckyNotes(){
	echo -e "\n" | add-apt-repository ppa:umang/indicator-stickynotes
	apt install indicator-stickynotes -y || apt update && apt install indicator-stickynotes -y
}
install_pycharm(){
	axel https://download.jetbrains.8686c.com/python/pycharm-community-2019.3.3.tar.gz	
	tar zxvf pycharm-community-*.tar.gz
	cd pycharm-community* && ./pycharm-community*/bin/pycharm.sh
}
install_intellij(){
	 axel https://download.jetbrains.8686c.com/idea/ideaIC-2019.3.3.tar.gz
	 tar zxvf idea*.tar.gz	
	 ./idea-IC*/bin/idea.sh

}
install_jad(){
	axel https://varaneckas.com/jad/jad158e.linux.intel.zip
	unzip jad*.zip
	mv jad /work/software/ && rm -rf Readme.txt
	ln -s /work/software/jad /usr/bin/jad
}
install_kchmviewer(){
	apt install kchmviewer && clear
	echo "viewer->set unicode--->gb2312" && sleep 2
}
install_wallper(){
	apt install wallch
}
ServerManager(){
	source ./ubuntu_server.sh		
}


show_info(){
	echo "ubuntu18 配置脚本:"
	echo "
	1.redshift
	2.chrome
	3.conky
	4.wps
	5.mpv
	6.flameshot
	7.kazam
	8.evernote
	9.sticky notes
	10.Server manager
	11.eclipse
	12.pycharm
	13.intellij
	14.java反编译工具jad(依赖库未解决)
	15.chm查看器
	16.自动切换壁纸
	"
	echo -e "q键退出\n"
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
ubuntu_main(){
	initialize
	clear
	show_info
}

ubuntu_main
