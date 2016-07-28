#!/bin/bash
#Filename: remove_duplicates.sh
#Description:  Find and remove duplicate files and keep one sample of each file.

#ls -lS  将当前目录下的所有文件按照文件大小进行排序,并列出文件的详细信息
#在从文件中读取文本行之前,首先要执行awk的begin{}语句块
#ll输出中的第一行 total 我们需要过滤掉,这里用getline读取第一行,然后过滤该行


ls -lS --time-style=long-iso | awk 'BEGIN { 
  getline; getline; 
  name1=$8; size=$5     # 存储文件名和大小
} 
# 接下来awk进入{}语句块,读取到的没一行文本都会执行该语句块
{
  name2=$8; 
  if (size==$5) 
  { 
    "md5sum "name1 | getline; csum1=$1;   # awk中外部命令的输出可以用getline读取
    "md5sum "name2 | getline; csum2=$1;   # $0 获取命令的输出,$1,$2...获取第一列,第二列
    if ( csum1==csum2 ) 
    {
      print name1; print name2
    }
  };

  size=$5; name1=name2; 
}' | sort -u > duplicate_files 

# md5sum的字符长度32       每组重复文件的一个采样写入duplicate_sample
cat duplicate_files | xargs -I {} md5sum {} | sort | uniq -w 32 | awk '{ print "^"$2"$" }' | sort -u >  duplicate_sample
echo Removing..

# comm通常只接受有序的文件,所以在重定向的时候 sort -u进行处理
# tee 命令将文件名转给rm的同时,将来自stdin的行写入文件,同时将其发送到stdout,这里重定向到stderr
comm duplicate_files duplicate_sample  -2 -3 | tee /dev/stderr | xargs rm
echo Removed duplicates files successfully.
