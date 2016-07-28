#!/bin/bash
#create_db.sh
#用途:创建mysql数据库和数据库表

USER="root"
PASSWD="root"

mysql -u $USER -p$PASSWD <<EOF 2>/dev/null
	CREATE DATABASE students;
EOF

[ $? -eq 0 ] && echo Create DB || echo DB already exist

# mysql命令通过标准输入(stdin)接受查询
# 通过stdin提供多行输入的简便方法是使用<<EOF
# 在<<EOF 和 EOF之间的文本被作为mysql的标准输入
# 为了避免显示错误信息,将stderr重定向到/dev/null
mysql -u $USER -p$PASSWD students <<EOF 2> /dev/null
create table students(
	id int,
	name varchar(100),
	mark int,
	dept varchar(4)
	);
EOF

# 用退出状态变量来检查mysql命令的退出状态
[ $? -eq 0 ] && echo Create table students || echo Table students already exist

mysql -u $USER -p$PASSWD students <<EOF
delete from students;
EOF