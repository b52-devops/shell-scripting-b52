#!/bin/bash

set -e

COMPONENT=frontend
LOGFILE=/tmp/$COMPONENT.log

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

echo -n "\e[32m ________ $COMPONENT Configuration is Starting _________ \e[0m"

echo -n "Installing Nginx :"
yum install nginx -y        &>> $LOGFILE
stat $?

echo -n "Downloading the $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"

stat $?

echo -n "Clearing the old default content: "
cd /usr/share/nginx/html
rm -rf *    &>> $LOGFILE
stat $?
echo -n "Extracting $COMPONENT : "
unzip /tmp/$COMPONENT.zip    &>> $LOGFILE
stat $?

echo -n "Copying $COMPONENT : "
mv frontend-main/* .     &>> $LOGFILE
mv static/* .            &>> $LOGFILE
rm -rf frontend-main README.md       &>> $LOGFILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf         &>> $LOGFILE
stat $?

echo -n "Restarting Nginx :"
systemctl enable nginx      &>> $LOGFILE
systemctl restart nginx       &>> $LOGFILE
stat $?

echo -n "\e[32m ________ $COMPONENT Configuration Completed _________ \e[0m"
