#!/bin/bash
echo "please input three number:"

read -p "first number:" n1
read -p "second number:" n2
read -p "third number:" n3

let max=$n1

if [ $n2 -ge $n1 ]; then
    max=$n2
fi
if [ $n3 -ge $max ]; then
    max=$n3
fi
echo "the max number is $max"
