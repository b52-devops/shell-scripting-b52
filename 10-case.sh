#!/bin/bash

# case $var in 
#     opt1) commands1 ;;
#     opt2) commands2 ;;
# esac


case $ACTION in
    start)
        echo "XYZ Service is starting"
        ;;
    stop)
        echo "XYZ Service is stopping"
        ;;
    restart)
        echo "XYZ Service is restarting"
        ;;
esac