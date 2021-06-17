#!/bin/bash

#centos7安装objective-c环境:
echo "安装jcc "
yum install gcc gcc-objc -y 

echo "编译前安装依赖"
yum install  make libpng libpng-devel libtiff libtiff-devel -y
yum install -y  libxml2 libxml2-devel libX11-devel libXt-devel 
yum install -y libjpeg libjpeg-devel   libxslt libxslt-devel  
yum install gnutls gnutls-devel libicu libicu-devel libobjc libffi libffi-devel -y 
yum install  libffi  libffi-devel libxslt-devel -y 
yum -y install gnustep-base gnustep-base-devel gnustep-base-doc gnustep-base-libs gnustep-filesystem gnustep-make gnustep-make-doc

echo "编译安装gnustep-config"
#wget http://ftpmain.gnustep.org/pub/gnustep/core/gnustep-startup-0.32.0.tar.gz
tar xzvf gnustep-startup-0.32.0.tar.gz
cd gnustep-startup-0.32.0 && ./InstallGNUstep
echo "status:"
echo $?
sleep 6.3
cd .. #exit
echo '. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh' >> /etc/profile
source /etc/profile


echo '#import <Foundation/Foundation.h>
 
int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSLog (@"hello world");
    [pool drain];
    return 0;
}

' > test.m 

echo "创建编译脚本"
echo '#!/bin/bash
#compile-objective-c.sh test.m output
if [ ! -n "$1" ]
then
	echo "使用: ./compile-objective-c.sh test.m helloworld"
else 
	gcc `gnustep-config --objc-flags` -L/usr/GNUstep/System/Library/Libraries -lgnustep-base -lobjc $1 -o $2
fi
' > compile-objective-c.sh 
chmod +x compile-objective-c.sh 

clear

echo "编译测试"
./compile-objective-c.sh test.m hello
./hello




