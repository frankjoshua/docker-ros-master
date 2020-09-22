# ROS master in Docker ![https://hub.docker.com/r/frankjoshua/ros-master](https://img.shields.io/docker/pulls/frankjoshua/ros-master) [![Build Status](https://travis-ci.org/frankjoshua/docker-ros-master.svg?branch=master)](https://travis-ci.org/frankjoshua/docker-ros-master)

##

Runs a ros master in a Docker container. Probably need --network="host" because ROS uses ephemeral ports.

## Example

```
docker run -it \
    --network="host" \
    --env="ROS_IP=$ROS_IP" \
    --env="ROS_MASTER_URI=$ROS_MASTER_URI" \
    frankjoshua/ros-master
```
