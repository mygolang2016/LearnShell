#!/bin/bash
#用途:从csv中读取数据并写入MySQLdb

USER="root"
PASSWD="root"

if [ $# -ne 1 ]; then
	echo $0 DATAFILE
	echo
	exit 2
fi

data=$1
# 用while循环来读取csv文件的每一行
while read line
do
	oldIFS=$IFS
	IFS=','
  # 数组赋值形式array=(var1 var2 var3) 空格分隔
  # csv是逗号分隔,所以将IFS改为,用($line)赋值给数组
  # id name mark department
  # ${stement}  name中也可以包含空格,这样一来就和IFS冲突了
  # 我们将name中的空格替换为#,在构建查询语句再替换回来
  # 为了引用字符串,数组中的值要加上\"
	values=($line)
	values[1]="\"`echo ${values[1]} | tr ' ' '#' `\""
	values[3]="\"`echo ${values[3]}`\""
	query=`echo ${values[@]} | tr ' #' ', ' `
	IFS=$oldIFS

	mysql -u $USER -p$PASSWD students <<EOF
		insert into students values($query);
EOF
done< $data
echo Wrote data into DB