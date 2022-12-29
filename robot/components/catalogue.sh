#!/bin/bash
set -e
COMPONENT=catalogue
source common.sh    # source loads a file and this file has all the common patterns

echo -n "Configuring NodeJS repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -    &>> ${LOGFILE}
yum install nodejs -y   &>> ${LOGFILE}
stat $?

id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating Application User $APPUSER : "
    useradd $APPUSER    &>> ${LOGFILE}
    stat $?
fi

echo -n "Downloading the $COMPONENT : "
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip     &>> ${LOGFILE}
stat $?

# mv catalogue-main catalogue
# cd /home/roboshop/catalogue
# npm install
