# ROS master in Docker ![https://hub.docker.com/r/frankjoshua/ros-master](https://img.shields.io/docker/pulls/frankjoshua/ros-master) [![Build Status](https://travis-ci.org/frankjoshua/docker-ros-master.svg?branch=master)](https://travis-ci.org/frankjoshua/docker-ros-master)

## Description

Runs a ros master in a Docker container. Probably need --network="host" because ROS uses ephemeral ports.

This repo is mostly an example of how to build a multi architecture docker container with ROS (Robotic Operating System). Travis CI is used to build 3 docker containers using `docker buildx` amd64 (x86 Desktop PC), arm64 (Jetson Nano) and arm32 (Raspberry Pi). This is for the purpose of developing locally on a work pc or laptop. Then being able to transfer your work to an embedded device with a high level of confidence of success.

## Example

```
docker run -it \
    --network="host" \
    --env="ROS_IP=$ROS_IP" \
    --env="ROS_MASTER_URI=$ROS_MASTER_URI" \
    frankjoshua/ros-master
```
