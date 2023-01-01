#!/bin/bash 

COMPONENT=mysql

source components/common.sh    # Source loads a file and this file has all the common patterns.

echo -n "Configuring the $COMPONENT repo  : "
curl -s -L -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo  &>> "${LOGFILE}"
stat $? 

echo -n "Installing $COMPONENT: "
yum install mysql-community-server -y   &>> "${LOGFILE}"
stat $? 

echo -n "Starting $COMPONENT : "
systemctl enable mysqld
systemctl start mysqld 
stat $? 

echo -n "Fetching the default password :" 
DEFAULT_ROOT_PWD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $? 

# This should happen only if the default password is not changed, rest of the times, I don't want to change it.
echo show databases | mysql -uroot -pRoboShop@1 &>> "${LOGFILE}"
if [ $? -ne 0 ]; then 
    echo -n "Resetting the default root password : "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql  --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> "${LOGFILE}"
    stat $?
fi 

echo show plugins | mysql -uroot -pRoboShop@1 | grep validate_password;   &>> "${LOGFILE}"
if [ $? -eq 0 ]; then 
    echo -n "Uninstalling Password Validate Plugin "
    echo "uninstall plugin validate_password;"|  mysql -uroot -pRoboShop@1  &>> "${LOGFILE}"
    stat $?
fi 

echo -n "Downloading the $COMPONENT schema :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"   &>> "${LOGFILE}"
cd /tmp 
unzip -o $COMPONENT.zip  &>> "${LOGFILE}"
stat $? 

echo -n "Injecting the $COMPONENT Schema"
cd $COMPONENT-main
mysql -uroot -pRoboShop@1 <shipping.sql
stat $?

echo -e "\e[32m ______ $COMPONENT Configuration Completed _________ \e[0m"