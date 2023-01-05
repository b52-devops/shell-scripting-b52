#!/bin/bash

COMPONENT=$1

# AMI_ID="ami-00ff427d936335825"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b52-allow-all --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g')

echo "AMI ID Used to lauch the instance is $AMI_ID"
echo "Security Group ID Used to lauch the instance is $SG_ID"
echo "*****______ $COMPONENT launch is in progress ______*****"

aws ec2 run-instances --image-id ${AMI_ID} --count 1 --instance-type t2.micro --security-group-ids ${SG_ID} --tags Key=Name,Value=${COMPONENT}

