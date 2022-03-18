# Transbase Docker Image

The Transbase Docker image is based on [Alpine Linux](https://www.alpinelinux.org) and [Transbase](https://www.transaction.de/en/index.html).

## What is Transbase?

Transbase is a relational SQL database system. It is designed to deliver maximum performance with minimum resources. Therefore it can be used easily not only on high-end servers, but particularly on low-end platforms like Raspberry Pi. By consequently following accepted standards, Transbase secures your software investments. As a unique selling point, Transbase provides prize-awarded patented technologies that make your applications unique in fuctionality and performance.

> [wikipedia.org/wiki/Transbase](https://en.wikipedia.org/wiki/Transbase)

![logo](https://www.transaction.de/fileadmin/logos/transaction_logo_2x.png)

---

## Prerequisites

Download and install [Git](https://git-scm.com/downloads) and [Docker](https://docs.docker.com/get-docker/).

## Get a copy of the repository

Clone `transbase-docker` repository from GitHub:  
```
git clone https://github.com/TransactionSoftwareGmbH/transbase-docker.git
```
... and step into the project directory
```
cd transbase-docker
```
## Build the image

You can build the Transbase Docker image with default values
```
docker build -t transbase transbase/.
```
... or with custom build-time arguments
```
docker build -t transbase:8.3.1 --rm --build-arg ALPINE_VERSION=3.15 --build-arg TRANSBASE_VERSION=8.3.1 transbase/.
```
The following build-time arguments are available at the moment:
* ALPINE_VERSION: the version of the Alpine Linux base image e.g. "3.15"
* TRANSBASE_VERSION: the version of Transbase e.g. "8.3.1"

## Run the image as a container

For running the image please have a look at [README.md](https://github.com/TransactionSoftwareGmbH/transbase-docker/tree/master/transbase).