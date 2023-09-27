#!/bin/bash

#Create instance infrastructure 

terraform init && terraform apply --auto-approve  # set the Jenkins configure This project is parameterized to apply (or) destroy

sleep 5

# to get public IP and store the variable 

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=PUBLIC_NODE" --query "Reservations[].Instances[].PublicIpAddress" --output text )

#b=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=PRIVATE_NODE" --query "Reservations[].Instances[].PublicIpAddress" --output text )

echo "$a"
#echo "$b"

echo "Terraform Exceute Successfully"

