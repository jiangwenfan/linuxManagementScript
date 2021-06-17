import os
import time
import sys
#检测笔记本是否断电，断电之后关闭虚拟机，并进行主动关机。

# gateWayIp = str(input("输入网关/路由器ip: eg:192.168.1.1"))
gateWayIp = "192.168.31.21"  # test
cmd2 = "ping "+gateWayIp+" -c 3" #linux
cmd1 = "ping " + gateWayIp  # windows

def windowsPowerOffStatus():
    """
    返回是否断电，适用于windows系统
    :return: 1 断电   0 正常
    """
    resultList = os.popen(cmd1).read().strip().split("\n")

    #正常ping
    if(len(resultList) == 10):
        infoList = resultList[-3].strip().split("，")
    #非正常ping
    elif(len(resultList) == 8):
        infoList = resultList[-1].strip().split("，")

    lossRate = infoList[-2].split(" ")[-2].replace("(", "")  # 0%
    if(lossRate == "100%"):
        return 1 #断电了
    else:
        #0% 25% 判断数据包是否有响应
        dataList = resultList[1:5]
        for i in dataList:
            info = i.split(":")[-1].strip()
            if(info == "无法访问目标主机。"):
                return 1 #断点了
            else:
                return 0 #normal
def linuxPowerOffStatus():
    """
    返回linux系统是否断电。 1 断电     0 正常
    :return:
    """
    resultList = os.popen(cmd2).read().strip().split("\n")
    if(len(resultList) == 8):
        if(resultList[-1] == "pipe 3"): #ping不通的结果
            return 1
        else:
            return 0
    elif(len(resultList) == 4):
        return 1 #断电了

def shutdownVirtualMachine():
    """
    关闭虚拟机，返回关闭状态
    return 0 表示关闭成功
    return 1 表示关闭失败
    :return:
    """
    count = 0 #关闭次数
    #最多尝试进行10次关闭虚拟机
    while(count <= 10):
        virtualUuidList = os.popen("virsh list --uuid").read().strip().split("\n")
        #当虚拟机个数为1个及以上时，进行关闭操作。
        if(len(virtualUuidList) != 0):
            print(len(virtualUuidList))
            for i in virtualUuidList:
                cmd2 = "virsh shutdown " + i
                os.system(cmd2)
        else:
            return 0
        count += 1
        time.sleep(2)
    return 1

def shutdownHost():
    """
    关闭宿主机
    :return:
    """
    res = shutdownVirtualMachine()
    #如果虚拟机全部关闭,则直接关闭宿主机。否则将信息发送到邮件
    if(res != 0):
        #send 发送邮件
        pass
    #os.system("shutdown now")
    print("宿主机已关机....") #test
    sys.exit(0)

#发送邮件到126邮箱

count = 0
if __name__ == "__main__":
    print("-----------")
    #每隔2秒进行判断一次,系统是否断电。
    while True:
        res = linuxPowerOffStatus()
        #print("status："+str(res))
        if res == 1:
            count += 1
            #当判断三次都是关机状态，才进行关机
            if(count == 3):
                shutdownHost()
        else:
            #global count
            count = 0 #重置全局变量
            print("normal ....")
        time.sleep(2)
