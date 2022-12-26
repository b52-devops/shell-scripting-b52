#!/bin/bash

DATE=$(date +%x)
echo "Good morning. todays date is $DATE"
echo "Total number of users signed in is $(who | wc -l"

# Always fetch the information dynamically for the variable which keep on changing, hardcoding creates complexity

# () : Paranthesis      : Expressions should be enclused in paranthesis 
# {} : Flower Brackets
# [] : Square Brackets 