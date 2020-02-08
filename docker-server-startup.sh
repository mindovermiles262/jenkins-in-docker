#!/bin/bash

if [ ! -d "$HOME/jenkins/vol/jenkins-server" ]; then
  echo "Local volumes not found . . . creating . . ."
  mkdir -p "$HOME/jenkins/vol/jenkins-server"
fi

docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v ~/jenkins/vol/jenkins-server:/vol/jenkins_home \
  --name jenkins-server \
  --network jenkins-net \
  jenkins/jenkins:lts
