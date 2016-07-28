#!/bin/bash
# Filename: filestat.sh

if [ $# -ne 1 ];
then
	echo “Usage is $0 basepath”;
	exit
fi
path=$1

declare -A statarray;

while read line;
do
	ftype=`file -b "$line" | cut -d, -f1`
	#有时候file输出的类型还包括详细的附加信息,信息字段之间用,隔开,我们取主要信息字段就行了
	#-d,  指定分隔符号,   -f1 取第一个字段
  	let statarray["$ftype"]++;

done < <(find $path -type f -print)

echo ============ File types and counts =============
for ftype in "${!statarray[@]}";
do
	# ${!statarray[@]} 返回数组的索引
	echo $ftype :  ${statarray["$ftype"]}
done
