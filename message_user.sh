#/bin/bash
USERNAME=$1

#目录/dev/pts中包含着与每一位系统终端中登入用户所对应的字符设备
device=`ls /dev/pts/* -l | awk '{ print $3, $10 }' | grep $USERNAME | awk '{ print $2 }'`
for dev in device
do
	# /dev/stdin包含传递给当前进程的标准输入数据
	cat /dev/stdin > $dev 
done