#!/bin/bash

set -e

docker buildx create --use
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t mozilla/ssh_scan .

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]; then
    echo $DOCKER_PASS | docker login -u="$DOCKER_USER" --password-stdin;\
    docker push mozilla/ssh_scan;\
  else
    exit 0
  fi
else
  exit 0
fi
