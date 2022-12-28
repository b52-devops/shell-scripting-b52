#!/bin/bash

# for list in val1 val2 val3 val4 val5 ; do 
#     echo "Value is $list"
# done

# For loop will be used  when the loop is based on inputs

# for courses in devops aws gcp azure terraform ansible docker ; do
#     echo "Course name is $courses"
# done

# while loop : a conditional loop   

i=10
while [ $i -gt 0 ] ; do
    echo "Iteration Number is $i"
    i=(($i-1))
done