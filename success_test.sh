#!/bin/bash
cmd="ls"
$cmd
if [ $? -eq 0 ]
then
	echo "$cmd executed successfully"
else
	echo "$cmd terminated unsuccessfully"
fi
