# Transbase Docker

Transbase Docker image - based on:
* [Alpine Linux](https://www.alpinelinux.org) -
an independent, non-commercial, general purpose Linux distribution designed for power users who appreciate security, simplicity and resource efficiency 
and 
* [Transbase](https://www.transaction.de/en/products/transbase) -
a relational SQL database system, developed as core product by  [Transaction Software GmbH](https://www.transaction.de/en/index.html)


## Prerequesites

Install Docker on your host: 
* [Docker Desktop for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
* [Docker Desktop for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
* [Docker Engine for Linux, e.g. Ubuntu](https://hub.docker.com/editions/community/docker-ce-server-ubuntu)
  (or use the package manager of your system, i.e. yum, apt, ...)

Start the Docker Desktop App resp. service/daemon

## Clone Repository

Clone the transbase-docker repository (branch: develop)  
from the GitHub [TransactionSoftwareGmbH](https://github.com/TransactionSoftwareGmbH/transbase-docker/tree/develop):  
```
git clone https://github.com/TransactionSoftwareGmbH/transbase-docker.git -b develop transbase-docker_dev
``` 

### Images

The transbase-docker repository contains two images  
* transbase - basic image,  contains a transbase default installation
* transbase-sample - basic image, contains transbase installation with a sample database


## Build Image

Build a new tagged image  
```
cd transbase-docker_dev/transbase  
docker build -t transbase .
```  


## Set Environment

To use Transbase Docker images you need a valid Transbase license file.  
Please request a  
* [Transbase Evaluation License](https://www.transaction.de/en/transbase/evaluation-version.html){target="blnak"}

Copy the received Transbase license file (`tblic.ini`) into the /transbase directory  
either by mounting a volume or using docker cp command, e.g.:  
```
docker create --name transbase transbase
docker cp tblic.ini transbase:/opt/transbase  
docker commit transbase transbase
```  


## Run
docker
Start your Transbase Docker container:  
```
docker run -it transbase
```
(the transbase service will be exposed at port 2024)  


## Use

Now you are in the shell of your Transbase/Docker-Container  
and you can evaluate Transbase, e.g.:  

```
tbi admin tbadmin transbase  # connect to transbase repository databases  
```  
```  
create database sample;      -- create a sample database  
quit  
```

```
tbi sample tbadmin ""
```
```
create table test ( id integer auto_increment primary key, 
subject char(100) not null, content varchar(*), 
created datetime[yy:ms] default currentdate);  
ct  
insert into test (subject, content) values ('Note 1','Hello Transbase');  
ct  
select id,subject,content,created from test;  
ct  
quit  
``` 