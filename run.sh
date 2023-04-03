#!/usr/bin/env bash
DOCKER="sudo docker"

whoami | grep -q root && DOCKER="docker"

echo $DOCKER build --network=host -t smartbot:latest -f Dockerfile .
$DOCKER build --network=host -t smartbot:latest -f Dockerfile --build-arg TELEBOT_TOKEN_API_ARG=${TELEBOT_TOKEN_API} .

echo $DOCKER run --rm -it smartbot:latest
$DOCKER run --rm -it smartbot:latest


