#!/bin/bash

COMPONENT=catalogue
source components/common.sh    # source loads a file and this file has all the common patterns

echo -n "Configuring NodeJS repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash  &>> ${LOGFILE}
stat $?

echo -n "Installing tNodeJS : "
yum install nodejs -y   &>> ${LOGFILE}

id $APPUSER &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
    echo -n "Creating Application User $APPUSER : "
    useradd $APPUSER    &>>     ${LOGFILE}
    stat $?
fi

echo -n "Downloading the $COMPONENT : "
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Cleanup and Extracting the $COMPONENT : "
rm -rf /home/$APPUSER/$COMPONENT/
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip     &>> ${LOGFILE}
stat $?

echo -n "Changing the ownership to $APPUSER : "
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "Installing $COMPONENT dependencies : "
cd $COMPONENT
npm install &>> $LOGFILE
stat $?
