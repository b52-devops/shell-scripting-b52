#!/bin/bash

# case $var in 
#     opt1) commands1 ;;
#     opt2) commands2 ;;
# esac
ACTION=$1

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
    *)
    echo -e  "\e[31m Valid options are start or stop or restart only \e[0m"
esac