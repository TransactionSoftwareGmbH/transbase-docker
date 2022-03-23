# version
ARG ALPINE_VERSION="3.15"

# start with minimal linux distribution 
FROM alpine:${ALPINE_VERSION}

# transfer args
ARG ALPINE_VERSION

# change this during build with --build-arg <KEY>=<value>
ARG TRANSBASE_VERSION="8.3.1"
ARG ARCHITECTURE="x64"
ARG TRANSBASE_DISTRIBUTION=transbase-${TRANSBASE_VERSION}_alpine-${ALPINE_VERSION}_${ARCHITECTURE}.tar.Z
ARG TRANSBASE_DOWNLOAD=https://www.transaction.de/downloads/transbase/${TRANSBASE_VERSION}/alpine/${ALPINE_VERSION}/${ARCHITECTURE}/${TRANSBASE_DISTRIBUTION}

LABEL transbase=${TRANSBASE_VERSION}
LABEL maintainer=Loibl<loibl@transaction.de>

# common sanity
#RUN apk update && apk add --no-cache bash

# download and copy transbase to container
ARG TRANSBASE="/opt/transbase"

WORKDIR ${TRANSBASE}

ADD databases.tar.Z /tmp

RUN 	wget ${TRANSBASE_DOWNLOAD} \
	&& 	tar -xzf ${TRANSBASE_DISTRIBUTION} \
	&&	rm ${TRANSBASE_DISTRIBUTION} \
	&& 	mv /tmp/databases ${TRANSBASE} \
	&&  chown -R root:root ${TRANSBASE}

# expose default port 2024 for transbase service
EXPOSE 2024:2024

# add transbase to path
ENV PATH /opt/transbase/bin:$PATH

# copy license file (uncomment if license file is available and building locally)
# otherwise license file has to be copied before running the container with docker cp command
# ADD tblic.ini /opt/transbase/tblic.ini

# start transbase service on container start
CMD transbase start && sh
