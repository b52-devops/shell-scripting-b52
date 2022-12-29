#!/bin/bash
set -e

COMPONENT=mongodb
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

echo -n "Downloading $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org  &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT : "
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema file"
cd /tmp
unzip -o mongodb.zip       &>> $LOGFILE
stat $?

echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js     &>> $LOGFILE
mongo < users.js         &>> $LOGFILE
stat $?