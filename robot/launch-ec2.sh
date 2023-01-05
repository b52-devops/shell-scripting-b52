#!/bin/bash

COMPONENT=$1

# AMI_ID="ami-00ff427d936335825"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b52-allow-all --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g')

echo "AMI ID Used to lauch the instance is \e[32m $AMI_ID \e[0m"
echo "Security Group ID Used to lauch the instance is \e[32m $SG_ID \e[0m"
echo "*****______ $COMPONENT launch is in progress ______*****"

PRIVATE_IP=${aws ec2 run-instances --image-id ${AMI_ID} --count 1 --instance-type t2.micro --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g'}

echo -e "Private IP of the $COMPONENT Server is  \e[32m $PRIVATE_IP \e[0m"

echo "*****______ $COMPONENT launch completed ______*****"

