#!/bin/bash

for i in {1..10}
do
    echo $((RANDOM / 20)) >> random

done

cat random

echo "----------------"

sort random

echo "-----------------"

sort -n random
