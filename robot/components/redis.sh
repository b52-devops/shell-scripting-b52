#!/bin/bash

COMPONENT=redis

source components/common.sh    # source loads a file and this file has all the common patterns

echo -n "Downloading $COMPONENT repo : "
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo  &>> ${LOGFILE}
stat $?

echo -n "Installing $COMPONENT : "
yum install redis-6.2.7 -y   &>> ${LOGFILE}
stat $?

echo -n "Whitelisting the $COMPONENT"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl enable $COMPONENT &>> ${LOGFILE}
systemctl start $COMPONENT  &>> ${LOGFILE}
stat $?
