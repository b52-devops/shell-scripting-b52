LOGFILE=/tmp/$COMPONENT.log
APPUSER=roboshop

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

NODEJS() {
    echo -n "Configuring NodeJS repo : "
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash  &>> ${LOGFILE}
    stat $?

    echo -n "Installing tNodeJS : "
    yum install nodejs -y   &>> ${LOGFILE}
    stat $?

    CREATE_USER             # Calling CREATE_USER FUNCTION to crete user account

    DOWNLOAD_AND_EXTRACT    # Calling DOWNLOAD_AND_EXTRACT FUNCTION to download and extract the cmponent

    NPM_INSTALL             # Calling NPM_INSTALL Function

    CONFIGURE_SVC           # Configuring and installing service

}

CREATE_USER(){
    id $APPUSER &>> ${LOGFILE}
    if [ $? -ne 0 ] ; then
        echo -n "Creating Application User $APPUSER : "
        useradd $APPUSER    &>>     ${LOGFILE}
        stat $?
    fi
}

DOWNLOAD_AND_EXTRACT(){
    echo -n "Downloading the $COMPONENT : "
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
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
}

NPM_INSTALL(){
    echo -n "Installing $COMPONENT dependencies : "
    cd $COMPONENT
    npm install &>> $LOGFILE
    stat $?
}

CONFIGURE_SVC(){
    echo -n "Configuring the $COMPONENT Service : "
    sed -i -e 's/REDIS_DNSNAME/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
    mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    stat $?

    echo -n "Starting the $COMPONENT Service : "
    systemctl daemon-reload     &>> ${LOGFILE}
    systemctl enable $COMPONENT  &>> ${LOGFILE}
    systemctl restart $COMPONENT &>> ${LOGFILE}
    systemctl status $COMPONENT &>> ${LOGFILE}
    stat $?

    echo -e "\e[32m ________ $COMPONENT Configuration Completed _________ \e[0m"
}
