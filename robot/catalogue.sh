#!/bin/bash
set -e

COMPONENT=catalogue

source robot/common.sh    # source loads a file and this file has all the common patterns

echo -n "Configuring NodeJS repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install nodejs -y   &>> $LOGFILE
stat $?

echo -n "Creating Application User $APPUSER"
useradd $APPUSER
stat $?
