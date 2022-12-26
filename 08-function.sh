#!/bin/bash

Declaring a sample function
sample(){
echo "I am a sample function"
echo "IF you want to call me, just type sample"
echo "sample function is completed"
}

# Calling the sample function
sample

stat(){
    echo "Number of open sessions : $(who | wc -l)"
    echo "Todays date is : $(date =%x)"
    echo "Load average of the system in last 1 minute is : $(uptime | awk -F : '{print $5}' | awk -F , '{print $1}')"
}