#!/bin/bash

#docker build -t transbase .
docker create --name transbase transbase
docker cp tblic.ini transbase:/transbase
docker commit transbase transbase