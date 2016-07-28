#!/bin/bash
function DEBUG()
{
	[ "$_DUBUG" == "on" ] && $@ || :     # : 相当于python pass
}
for i in {1..5}
do
	DEBUG echo $i

done
