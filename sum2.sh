#!/bin/bash
sum=0
for i in $(seq 1 100)
do
    if [ $[$i%2] == 0 ]; then
	let sum+=$i
    fi
done
echo "the sum is $sum"
