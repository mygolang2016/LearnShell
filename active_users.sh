#!/bin/bash
#用途: 查找活跃用户

log=/var/log/wtmp

if [[ -n $1 ]];then
	log=$1
fi

printf "%-4s %-10s %-10s %-6s %-8s\n"\
 "Rank" "User" "Start" "Logins" "Usage hours"

# head -n -2 截取到倒数第二行前
last -f $log | head -n -2 > /tmp/ulog.$$
cat /tmp/ulog.$$ | cut -d' ' -f1 | sort |uniq > /tmp/users.$$

(
while read user
do
	# 日志的最后一列是登入会话的时长
	grep ^$user /tmp/ulog.$$ > /tmp/user.$$
	minutes=0
	# 累加用户所有登入时长
	while read t
	do
		#使用时间的格式是小时:秒,需要转换为分钟
		# -F定界符 这里:为定界符 -F: ,如何是放在BEGIN
		# 语句中,则为 FS=":"
		s=$(echo $t | awk -F: '{print ($1 * 60) + $2}')
		let minutes=minutes+s
	done< <(cat /tmp/user.$$ | awk '{ print $NF }' | tr -d ')(')
	# <(cmd) 将时长字符串列表作为标准输入传递给while,相当于文件输入

	firstlog=$(tail -n 1 /tmp/user.$$ | awk '{print $5,$6}')
	nlogins=$(cat /tmp/user.$$ | wc -l)
	printf "%-10s %-10s %-6s %-8s\n" $user "$firstlog" $nlogins $hours

done < /tmp/users.$$
) | sort -nrk 4 |awk '{ printf("%-4s %s\n", NR, $0) }'
# NR 行号 $0整行
rm /tmp/users.$$ /tmp/user.$$ /tmp/ulog.$$