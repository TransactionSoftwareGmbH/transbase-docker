# start with minimal linux distribution 
# but we require gblic for transbase
FROM frolvlad/alpine-glibc:latest

LABEL Daniel Loibl<daniel.loibl@gmail.com>

# change this during build with --build-arg TRANSBASE_DIST=value
ARG TRANSBASE_DIST=transbase-8_1_1_81-centos-7-x86_64.tar.Z
ARG DOWNLOAD_URL=https://www.transaction.de/downloads/transbase_trial_version/tb8_1_1/linux-x86_64/builds/$TRANSBASE_DIST

# common sanity
RUN apk update && apk add --no-cache sudo bash


# download and copy transbase to container
WORKDIR /transbase
RUN wget $DOWNLOAD_URL && tar -zxvf $TRANSBASE_DIST && rm $TRANSBASE_DIST

# create default database 
ADD databases.tar.gz /transbase/

# expose default port 2024 for transbase service
EXPOSE 2024:2024

# add transbase to path
ENV PATH /transbase/bin:$PATH

# copy license file (uncomment if license file is available and building locally)
# otherwise license file has to be copied before running the container with docker cp command
# ADD tblic.ini /transbase/tblic.ini

# start transbase service on container start
CMD transbase start && bash