#!/bin/bash
# sighandle.sh
# 用途:信号处理程序

function handler()
{
	echo "Hey, received signal: SIGINT"
}

echo "My process ID is $$"
trap 'handler' SIGINT

while true
do
	sleep 1
done