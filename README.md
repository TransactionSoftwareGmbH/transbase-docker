# Transbase Docker

Transbase Docker images  
based on Alpin Linux (Version 3.14.2) - a lightweight Linux distribution:  
  https://www.alpinelinux.org  
and Transbase Evaluation (Version 8.1.1):   
  https://www.transaction.de  


## Setup 

Install Docker on your host: 
* Windows: https://hub.docker.com/editions/community/docker-ce-desktop-windows
* Mac: https://hub.docker.com/editions/community/docker-ce-desktop-mac
* Linux, e.g. Ubuntu: https://hub.docker.com/editions/community/docker-ce-server-ubuntu
  (or use package mananger of your system, e.g. yum, apt)

Start the Docker Desktop App resp. service/daemon

## Clone

Clone transbase-docker -> branch develop  
from GitHub repository TransactionSoftwareGmbH:  
`git clone https://github.com/TransactionSoftwareGmbH/transbase-docker.git -b develop`

### Images

The transbase-docker repository contains two images  
* transbase - basic image,  contains a transbase default installation
* transbase-sample - basic image, contains transbase installateion with a sample database


## Build

Build a new tagged image  
`cd transbase-docker/transbase`  
`docker build . -t transbase`  


## Config

To use Transbase Docker images you need a valid Transbase license file.  
Please request a Transbase Evaluation license file:  
* https://www.transaction.de/en/transbase/evaluation-version.html  

Copy the received Transbase license file (tblic.ini) into the /transbase directory  
either by mounting a volume or using docker cp command, e.g.:  
`docker create --name transbase transbase`  
`docker cp tblic.ini transbase:/transbase`  
`docker commit transbase transbase`  


## Run

Start your Transbase Docker container:  
`docker run -it transbase`  
(the transbase service will be exposed at port 2024)  


## Use

Now you are in the shell of your Transbase/Docker-Container  
and you can evaluate Transbase, e.g.:  

`tbi admin tbadmin tbadmin`   // connect to transbase repository databases  
> create database sample;     // create a sample database  
> quit  
  
`tbi sample tbadmin ""`  
> create table test ( n integer auto_increment primary key, s varchar(*));  
> ct  
> insert into test (s) values ('Hello Transbase');  
> ct  
> select * from test;  
> ct  
> quit  
  