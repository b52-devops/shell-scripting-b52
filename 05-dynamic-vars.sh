#!/bin/bash

DATE=$(date +%x)
echo -e "Good morning. todays date is \e[34m $DATE \e[0m"
echo -e "Total number of opened sessions is \e[31m $(who | wc -l) \e[0m"

# Always fetch the information dynamically for the variable which keep on changing, hardcoding creates complexity

# () : Paranthesis      : Expressions should be enclused in paranthesis 
# {} : Flower Brackets
# [] : Square Brackets 