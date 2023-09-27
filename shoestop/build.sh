#!/bin/bash

# Create image using dockerfile

docker build -t hackathon:"$BUILDNUMBER" .

