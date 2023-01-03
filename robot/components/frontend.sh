#!/bin/bash

COMPONENT=frontend
source components/common.sh    # Source loads a file and this file has all the common patterns.

echo -e "\e[32m ______ $COMPONENT Configuration is Starting  _________ \e[0m"

echo -n "Installing Nginx :"
yum install nginx -y     &>> "${LOGFILE}"
stat $? 

echo -n "Downloading the $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Clearing the default content : "
cd /usr/share/nginx/html
rm -rf *    &>> "${LOGFILE}"
stat $? 

echo -n "Extracting $COMPONENT : "
unzip -o /tmp/$COMPONENT.zip  &>> "${LOGFILE}"
stat $? 

echo -n "Copying $COMPONENT : "
mv frontend-main/* .   &>> "${LOGFILE}"
mv static/* .          &>> "${LOGFILE}"
rm -rf frontend-main README.md  &>> /tmp/frontend.log 
mv localhost.conf /etc/nginx/default.d/roboshop.conf   &>> "${LOGFILE}"
stat $? 

for component in catalogue cart user shipping payment; do     # for loop 
    echo -n "Updating the $component backend reverse proxy dns records:"
    sed -i -e "/$component/s/localhost/$component.roboshop.internal/"  /etc/nginx/default.d/roboshop.conf  
    stat $? 
done 

echo -n "Retarting Nignx :"
systemctl enable nginx    &>> "${LOGFILE}"
systemctl restart nginx   &>> "${LOGFILE}"
stat $?

echo -e "\e[32m ______ $COMPONENT Configuration Completed _________ \e[0m"