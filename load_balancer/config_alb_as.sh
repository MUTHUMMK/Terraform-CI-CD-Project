#!/bin/bash

# get the value from dynamic instance

b=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=PUBLIC_NODE" --query "Reservations[].Instances[].InstanceId" --output text )

c=$(aws ec2 describe-vpcs --region ap-south-1 --filters "Name=tag:Name,Values=MY_VPC" --query "Vpcs[0].VpcId" --output text)

d=$(aws ec2 describe-subnets --region ap-south-1 --filters "Name=tag:Name,Values=public_subnet_1" --query "Subnets[*].SubnetId"  --output text)

e=$(aws ec2 describe-subnets --region ap-south-1 --filters "Name=tag:Name,Values=public_subnet_2" --query "Subnets[*].SubnetId"  --output text)

# Below values are replaced the variable.tf
echo "$b"

sed -i "s/instance-id/$b/g" variable.tf

echo "$c"

sed -i "s/vpc-id/$c/g" variable.tf

echo "$d"

sed -i "s/subnet_1/$d/g" variable.tf

echo "$e"

sed -i "s/subnet_2/$e/g" variable.tf

cat variable.tf

# Using Terraform to create ALB infrastructure

terraform init --migrate-state && terraform plan && terraform apply --auto-approve # set the Jenkins configure This project is parameterized to apply (or) destroy

