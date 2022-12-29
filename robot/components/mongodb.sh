#!/bin/bash
set -e

COMPONENT=mongodb

source common.sh    # source loads a file and this file has all the common patterns

echo -n "Downloading $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org  &>> $LOGFILE
stat $?

echo -n "Whitelisting the $COMPONENT"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl enable mongod
systemctl restart mongod
stat $?

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema file : "
cd /tmp
unzip -o mongodb.zip       &>> $LOGFILE
stat $?

echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js     &>> $LOGFILE
mongo < users.js         &>> $LOGFILE
stat $?