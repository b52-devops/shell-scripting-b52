#!/bin/bash

ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo  -e "\e[31m You need to run the script as a root user or with a sudo prevililege \e[0m"
    exit 1 
fi

echo "Installing Nginx :"
yum install nginx -y        &>> /tmp/frontend.log
systemctl enable nginx      &>> /tmp/frontend.log

echo "Starting Nginx :"
systemctl start nginx       &>> /tmp/frontend.log
