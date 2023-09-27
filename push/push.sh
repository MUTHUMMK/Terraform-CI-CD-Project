#!/bin/bash

# login dockerhub  
docker login -u $DOCKERHUBUSER -p $DOCKERHUBPSW

docker tag hackathon:$BUILD_NUMBER muthummkdh/hackathon:$BUILD_NUMBER

# Push the images to docker repository

docker push muthummkdh/hackathon:$BUILD_NUMBER