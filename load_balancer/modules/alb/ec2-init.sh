#!/bin/bash
sudo systemctl restart docker
sudo docker restart $(sudo docker ps -aq) 
#user_data = filebase64("${path.module}/ec2-init.sh")