pip3 install virtualenv
pip3 install virtualenvwrapper

echo '
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3 	
export WORKON_HOME=$HOME/.virtualenvs  
' >>  ~/.bashrc 	

#ln -s /usr/bin/python3 /usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh #python3 must is /usr/local/bin/python3
source ~/.bashrc 

#mkvirtualenv -p python3 test1 
#创建虚拟环境 
#.virtualenvs/test1 虚拟环境的具体存放路径 
#rmvirtualenv t1 #删除虚拟环境 
#workon #查看所有虚拟环境 
#deactivate #退出虚拟环境 
#workon test1 #进入虚拟环境
#pip list pip freeze #查看已安装的包 pip install django==1.8.2

