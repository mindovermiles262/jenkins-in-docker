#!/bin/bash

# Check for local volume mounts
VOL_DIR="$(pwd)/../vol/jenkins-server"
if [ ! -d "$VOL_DIR" ]; then
  printf "Local volume directory not found. Creating ... "
  mkdir -p "$VOL_DIR"
  echo "Done."
else
  echo "Jenkins Server volume directory already exists. Continuing ..."
fi

# Create 'jenkins-net' docker network
docker network ls | awk '{print $2}' | grep jenkins-net
if [ $? -eq 0 ]; then
  echo "jenkins-net network found"
else
  docker network create jenkins-net
fi

RDM_NUM=$(( $RANDOM ))
# Start Jenkins Master Server
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v $VOL_DIR:/vol/jenkins_home \
  --name jenkins-server-$(RDM_NUM) \
  --network jenkins-net \
  jenkins/jenkins:lts
