# Use the node.js 14 for base image used to building our application

FROM node:14-alpine

#set the working directory 

WORKDIR /muthu

# copy the end with all .json files to inside the working directory

COPY .*json .

# npm install for application dependencies

RUN npm install

# copy the extras application files 

COPY . ./

# start the application

CMD [ "npm","start" ]