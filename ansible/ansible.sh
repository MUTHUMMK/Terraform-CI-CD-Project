#!/bin/bash

# to get public IP and store the variable 

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=PUBLIC_NODE" --query "Reservations[].Instances[].PublicIpAddress" --output text )

#b=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=PRIVATE_NODE" --query "Reservations[].Instances[].PublicIpAddress" --output text )

echo "$a"
#echo "$b"

# inserting the dynamically created ip to the inventory.txt file 

sed -i "s/dynamic_ip/$a/g" inventory.txt

cat inventory.txt
