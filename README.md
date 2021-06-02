# Transbase Docker

All Transbase Docker images are based on a minimal linux distribution (alpine with glibc) (~6.6MB).

## Setup and Build

Install docker
Windows: https://docs.docker.com/docker-for-windows/install/
Mac: https://docs.docker.com/docker-for-mac/install/
Linux: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Build a new tagged image
`docker build . -t transbase`

To use transbase docker images you need to copy a valid license tblic.ini to /transbase,
either by mounting a volume or using docker cp command.

To run the image (transbase service will be exposed at port 2024)
`docker run -it transbase`

## Images

# transbase

Base image containing only a transbase default installation