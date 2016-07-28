#!/bin/bash
echo -e "please enter your passworld:"
stty -echo
read password
stty echo
echo 
echo Passworld read.
echo $password
