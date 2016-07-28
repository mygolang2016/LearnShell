#!/bin/bash
sum=0
for i in {1..50}
do
    sum=$(($sum + 2 * $i))
    
done
echo "the sum is $sum"
