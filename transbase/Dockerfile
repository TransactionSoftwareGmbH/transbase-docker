# build arguments
ARG TRANSBASE_VERSION="8.4.1"
ARG ALPINE_VERSION="3.16"

# base image
FROM alpine:${ALPINE_VERSION}

# transfer build arguments
ARG ALPINE_VERSION
ARG TRANSBASE_VERSION
ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-"linux/amd64"}

# initialize environment
ENV TRANSBASE /transbase
ENV TRANSBASE_DATABASE_HOME "${TRANSBASE}/databases"
ENV TRANSBASE_SYSLOG "${TRANSBASE}/syslog"
ENV TRANSBASE_PORT 2024
ENV LANG C.UTF-8
ENV PATH "${PATH}:${TRANSBASE}/bin"

# install required software
RUN apk add --update --no-cache musl-locales musl-locales-lang && \
# create user "tbadmin:transbase"
    addgroup -S -g 1000 transbase && \
    adduser -S -u 1000 -D -s /bin/sh -G transbase -H -h "${TRANSBASE}" tbadmin && \
    mkdir "${TRANSBASE}" && \
    chown tbadmin:transbase "${TRANSBASE}"

# switch from root to tbadmin
USER tbadmin:transbase

# set working directory
WORKDIR "${TRANSBASE}"

# copy entrypoint shell script
COPY --chown=tbadmin:transbase docker-entrypoint.sh .

# make entrypoint shell script executable
RUN chmod +x docker-entrypoint.sh && \
# download and extract transbase binaries
    wget https://www.transaction.de/downloads/transbase/${TRANSBASE_VERSION}/alpine/${ALPINE_VERSION}/${TARGETPLATFORM}/transbase.tar.Z && \
    tar -xzvf transbase.tar.Z \
        ./bin/transbase \
        ./bin/tbi \
        ./bin/libtci.so \
        ./docs/thirdparty.txt \
        ./docs/eula_en.txt && \
    rm transbase.tar.Z && \
# create directory for database files and syslog
    mkdir -p "${TRANSBASE_DATABASE_HOME}" "${TRANSBASE_SYSLOG}"

# create docker volume for database files
VOLUME "${TRANSBASE_DATABASE_HOME}"

# expose port of transbase service
EXPOSE "${TRANSBASE_PORT}"

# run entrypoint shell script
ENTRYPOINT ["/bin/sh", "docker-entrypoint.sh"]