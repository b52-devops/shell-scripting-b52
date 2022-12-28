#!/bin/bash

UID=$(id -u)

if [ "$UID" -ne 0 ] ; then
    echo  -e "\e[31m You need to run the script as a root user or with a sudo prevililege \e[0m"
    exit 1 
fi
yum install nginx -y
systemctl enable nginx
systemctl start nginx
