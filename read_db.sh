#!/bin/bash
#用途:从数据库中读取数据

USER="root"
PASSWD="root"

depts=`mysql -u $USER -p$PASSWD students <<EOF | tail -n +2
	select distinct dept from students;
EOF`

for d in $depts
do
	echo Department: $d
	result="`mysql -u $USER -p$PASSWD students <<EOF
		# 设置变量i=0
		set @i:=0;
		select @i:=@i+1 as rank,name,mark from students where dept="$d" order by mark desc;
EOF`"

	echo "$result"
	echo
done