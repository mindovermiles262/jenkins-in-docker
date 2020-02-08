#!/bin/bash

# Check for local volume mounts
if [ ! -d "$HOME/jenkins/vol/jenkins-server" ]; then
  echo "Local volumes not found . . . creating . . ."
  mkdir -p "$HOME/jenkins/vol/jenkins-server"
fi

# Create 'jenkins-net' docker network
docker network ls | awk '{print $2}' | grep jenkins-net
if [ $? -eq 0 ]; then
  echo "jenkins-net network found"
else
  docker network create jenkins-net
fi

# Start Jenkins Master Server
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v ~/jenkins/vol/jenkins-server:/vol/jenkins_home \
  --name jenkins-server \
  --network jenkins-net \
  jenkins/jenkins:lts
