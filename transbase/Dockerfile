# build arguments
ARG TRANSBASE_VERSION="8.3.1"
ARG ALPINE_VERSION="3.15"

# base image
FROM alpine:${ALPINE_VERSION}

# transfer build arguments
ARG ALPINE_VERSION
ARG TRANSBASE_VERSION

# build transbase distribution url
ARG ARCHITECTURE="x64"
ARG TRANSBASE_DISTRIBUTION=transbase-${TRANSBASE_VERSION}_alpine-${ALPINE_VERSION}_${ARCHITECTURE}.tar.Z
ARG TRANSBASE_URL=https://www.transaction.de/downloads/transbase/${TRANSBASE_VERSION}/alpine/${ALPINE_VERSION}/${ARCHITECTURE}/${TRANSBASE_DISTRIBUTION}

# upgrade linux and install required software
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    musl-locales \
    musl-locales-lang \
    ca-certificates \
    && \
    update-ca-certificates

# initialize environment
ENV TRANSBASE /transbase
ENV TRANSBASE_DATABASE_HOME "${TRANSBASE}/databases"
ENV TRANSBASE_PORT 2024
ENV LANG C.UTF-8
ENV PATH "${PATH}:${TRANSBASE}/bin"

# create user "tbadmin:transbase"
RUN addgroup -S -g 1000 transbase && \
    adduser -S -u 1000 -D -s /bin/bash -G transbase -H -h "${TRANSBASE}" tbadmin && \
    mkdir "${TRANSBASE}" && \
    chown tbadmin:transbase "${TRANSBASE}"
USER tbadmin:transbase

# set working directory
WORKDIR "${TRANSBASE}"

# download and extract transbase binaries
RUN wget ${TRANSBASE_URL} && \
    tar -xzvf ${TRANSBASE_DISTRIBUTION} \
    ./bin/transbase \
    ./bin/tbi \
    ./bin/libtci.so \
    ./docs/thirdparty.txt \
    ./docs/eula_en.txt \
    && \
    rm ${TRANSBASE_DISTRIBUTION}

# create directory and docker volume for database files
RUN mkdir -p "${TRANSBASE_DATABASE_HOME}" && \
    chown -R tbadmin:transbase "${TRANSBASE_DATABASE_HOME}"
VOLUME "${TRANSBASE_DATABASE_HOME}"

# expose port of transbase service
EXPOSE "${TRANSBASE_PORT}"

# copy and run entrypoint shell script
COPY --chown=tbadmin:transbase docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/bin/sh", "docker-entrypoint.sh"]