#!/bin/bash

set -e

docker build -t $DOCKER_USER/ssh_scan .

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]; then
    echo $DOCKER_PASS | docker login -u="$DOCKER_USER" --password-stdin;\
    docker push $DOCKER_USER/ssh_scan;\
  else
    exit 0
  fi
else
  exit 0
fi
