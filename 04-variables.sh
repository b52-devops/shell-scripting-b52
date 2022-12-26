#!/bin/bash 

# What is variable ?
# A variable is somehting which holds the value or data which would keep on changing as per the situation and scenario's
# Typically we are telling the computer /program that uses this variable when running the scripts


a=10
b=20
c=30

# How to print the value of a variable 

echo a

# $a : telling system to print the value of a
# $  : is a specia variable , when added as a prefix to any variable it considers to extract the value from the variable

echo Value of a is $a
echo value of a is ${a}

# $a or ${a} both of them are same

echo "Printing value of c : $c" 
echo "Printing the value of d : $d"
