#base config:
git config --global user.name "jiangwenfan" #设置使用git时的姓名
git config --global user.email "zhan2103208467@163" #设置邮箱地址
git config --global color.ui auto

#
ssh-keygen -t rsa -C "zhan2103208467@163.com" 

echo -e "\n将公钥内容添加到github上:\n\n"
cat /root/.ssh/id_rsa.pub 
echo -e "\n\n"
#接受回车键，然后执行下面部分
#ssh -T git@github.com #测试连接
