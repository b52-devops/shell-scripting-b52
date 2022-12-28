#!/bin/bash

# case $var in 
#     opt1) commands1 ;;
#     opt2) commands2 ;;
# esac
ACTION=$1

case $ACTION in
    start)
        echo "XYZ Service is starting"
        exit 0
        ;;
    stop)
        echo "XYZ Service is stopping"
        exit 0
        ;;
    restart)
        echo "XYZ Service is restarting"
        exit 0
        ;;
    *)
    echo -e  "\e[31m Valid options are start or stop or restart only \e[0m"
esac