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