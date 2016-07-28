#!/bin/bash

SECS=3600
UNIT_TIME=60

STEPS=$(( $SECS / $UNIT_TIME ))

echo "Watching CPU USAGE..."

# COMMAND         %CPU
# init             0.0
# kthreadd         0.0
# ksoftirqd/0      0.0
# kworker/0:0H     0.0
# chrome           2.1
# firefox         14.8



for((i=0;i<STEPS;i++))
do
	# comm:命令名 pcpu表示cpu使用率
	# 该命令输出所有进程名及cpu使用率
	# 每个进程对应一行输出
	ps -eocomm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
	# tail -n +2 将ps输出中的头部和command %cpu去掉
	# $$表示当前脚本的进程ID
	sleep $UNIT_TIME
done

echo
echo "CPU eaters:"

cat /tmp/cpu_usage.$$ | awk '
	# 关联数组统计cpu使用情况
	{process[$1]+=$2}
	END{
		for(i in process)
		{
			printf("%-20s %s\n", i, process[i])
		}
	}
' | sort -nrk 2 | head
# 根据总的cpu使用情况依数值逆序排序