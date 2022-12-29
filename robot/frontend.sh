#!/bin/bash

set -e

COMPONENT=frontend

ID=$(id -u)
if [ "$ID" -ne 0 ] ; then
    echo  -e "\e[31m You need to run the script as a root user or with a sudo prevililege \e[0m"
    exit 1 
fi

stat(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
    fi
}

echo -n "Installing Nginx :"
yum install nginx -y        &>> /tmp/frontend.log
stat $?

echo -n "Downloading the $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"

stat $?

echo -n "Clearing the old default content: "
cd /usr/share/nginx/html
rm -rf *    &>> /tmp/frontend.log
stat $?
echo -n "Extracting $COMPONENT : "
unzip /tmp/COMPONENT.zip    &>> /tmp/frontend.log
stat $?

echo -n "Copying $COMPONENT : "
mv frontend-main/* .     &>> /tmp/frontend.log
mv static/* .            &>> /tmp/frontend.log
rm -rf frontend-main README.md       &>> /tmp/frontend.log
mv localhost.conf /etc/nginx/default.d/roboshop.conf         &>> /tmp/frontend.log
stat $?

echo -n "Restarting Nginx :"
systemctl enable nginx      &>> /tmp/frontend.log
systemctl restart nginx       &>> /tmp/frontend.log
stat $?
