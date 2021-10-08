#!/bin/bash
## Requires
## https://github.com/nektos/act
## Downloads 18GB be patient

if ! command -v act &> /dev/null
then
    echo "act cound not be found install from: https://github.com/nektos/act"
    exit
fi

echo "Docker login is required."
echo "Downloads about 18GB on first install be patient."
act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 -s DOCKERHUB_USERNAME -s DOCKERHUB_TOKEN