#!/bin/bash

# Checks for two arguments, secret and node name
if [ "$#" -ne 2 ]; then
      echo "Usage: ./docker-worker-startup.sh [SECRET] [NODE_NAME]"
      exit 1
fi

docker run \
  -d \
  --name jenkins-"$2" \
  -v ~/jenkins/vol/"$2":/home/jenkins/agent \
  --network jenkins-net \
  jenkins/jnlp-slave \
  -url http://jenkins-server:8080 \
  $1 \
  $2
