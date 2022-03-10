#!/bin/bash

arr[0]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz"
arr[1]="0123456789"
arr[2]="!@#$%^&*_=+?.>,<"
for (( i=0;i < $1; i++ )); do
	index=$((RANDOM % 3))
	echo -n "${arr[$index]:$(( RANDOM % ${#arr[$index]} )):1}"
done
echo
