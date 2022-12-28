#!/bin/bash

a="ABC"

# if [ "$a" == "xyz" ]; then
#     echo -e "\e[32m Both of them are equal \e[0m"

# fi

# If else condition

if [ "$a" == "xyz" ]; then
    echo -e "\e[32m Both of them are equal \e[0m"
    exit 0
else
    echo -e "\e[31m Both of them are NOT equal \e[0m"
    exit 1
fi

# Note :  Use ``==`` when you're dealing with strings, use -eq when dealing with numbers.

# Demo on else if 

c=$1

if [ "$c" -eq "10" ] ; then
    echo "Value of c is 10"

elif [ "$c" -eq "20" ] ; then
    echo "Value of c is 20"

elif [ "$c" -eq "30" ] ; then
    echo "Value of c is 30"

else
    echo "Value of c is NOT 10 or 20 or 30"

fi