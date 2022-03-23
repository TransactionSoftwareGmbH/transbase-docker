
# Quick reference

-	**Maintained by**:  
	[Transaction Software GmbH](https://github.com/TransactionSoftwareGmbH/transbase-docker)

-	**Where to get help**:  
	<support@transaction.de>, or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=transbase)

# Supported tags and respective `Dockerfile` links

-	[`8.3.1`, `latest`](https://github.com/TransactionSoftwareGmbH/transbase-docker/tree/master/transbase/Dockerfile)

# Quick reference (cont.)

-	**Where to file issues**:  
	[https://github.com/TransactionSoftwareGmbH/transbase-docker/issues](https://github.com/TransactionSoftwareGmbH/transbase-docker/issues)

-	**Supported architectures**: ([more info](https://github.com/docker-library/official-images#architectures-other-than-amd64))  
	[`amd64`](https://hub.docker.com/r/amd64/transbase/)

-	**Source of this description**:  
	[https://github.com/TransactionSoftwareGmbH/transbase-docker/tree/master/transbase](https://github.com/TransactionSoftwareGmbH/transbase-docker/tree/master/transbase)

# What is Transbase?

Transbase is a relational SQL database system. It is designed to deliver maximum performance with minimum resources. Therefore it can be used easily not only on high-end servers, but particularly on low-end platforms like Raspberry Pi. By consequently following accepted standards, Transbase secures your software investments. As a unique selling point, Transbase provides prize-awarded patented technologies that make your applications unique in fuctionality and performance.

> [wikipedia.org/wiki/Transbase](https://en.wikipedia.org/wiki/Transbase)

![logo](https://www.transaction.de/fileadmin/logos/transaction_logo_2x.png)

# How to use this image

The Transbase docker image needs a license file to run the service. If you don't have one you can obtain a license file from [Transbase Evaluation Version](https://www.transaction.de/en/transbase/evaluation-version.html) or [Transbase Licensing](https://www.transaction.de/en/products/transbase/licensing.html).

There are several ways to run Transbase:

## Run Transbase service from command line

```console
docker run -d \
    --name my-transbase \
    -p 2024:2024 \
    -e TRANSBASE_PASSWORD=secretpassword \
    -v "$(pwd)"/tblic.ini:/transbase/tblic.ini \
    transbase
```

## ... or with a custom `Dockerfile`

```dockerfile
FROM transbase
COPY --chown=tbadmin:transbase ./tblic.ini .
```

Execute the following command to build the Docker image:

```console
docker build -t transbase-with-license-file .
```

Then execute the following command to create and start a Transbase Docker container:

```console
docker run -d \
    --name my-transbase \
    -p 2024:2024 \
    -e TRANSBASE_PASSWORD=secretpassword \
    transbase-with-license-file
```

## ... or with `docker-compose` or `docker stack`

Example `docker-compose.yaml`:

```yaml
version: "3.7"

services:
  my-transbase:
    image: transbase
    ports:
      - 2024:2024
    environment:
      TRANSBASE_PASSWORD: secretpassword
      TRANSBASE_LICENSE_FILE: /run/secrets/tblic.ini
    secrets:
      - tblic.ini
    ...
```

## Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will start the Transbase command line interface `tbi` inside your Transbase container:

```
docker exec -it my-transbase tbi

no database> connect //localhost:2024/admin
Login: [tbadmin] 
Password:

admin-> select 1;
          1 

          1 

1 tuple evaluated
Elapsed time: 0.001 sec.

admin-> quit
```

## Environment Variables

The Transbase image uses several environment variables. The only variable required is `TRANSBASE_PASSWORD` or `TRANSBASE_PASSWORD_FILE`, the rest are optional.

### `TRANSBASE_PASSWORD`, `TRANSBASE_PASSWORD_FILE`

These environment variables set the password of the repository database `admin`. `TRANSBASE_PASSWORD` contains the password in plain text whereas `TRANSBASE_PASSWORD_FILE` specifies a file which contains the password of the repository database `admin`. Generally this variable is used to load the password from Docker secrets which are stored under `/run/secrets`.

### `TRANSBASE_LICENSE_FILE`

This optional environment variable specifies the location of the license file `tblic.ini`. The default location is `/transbase/tblic.ini`.

### `TRANSBASE_PORT`

This optional environment variable sets the TCP port on which transbase listens for incoming connections. Defaults to 2024.

### `TRANSBASE_MAX_THREADS`

This optional environment variable limits the number of threads, which deal with session contexts. One of these threads is occupied by a session as long as this session has at least one transaction open. If the maximum number of threads is reached, a session has to wait for another session to end its transaction. If this parameter is omitted, the number of threads is limited to 32.

### `TRANSBASE_CERTIFICATE_FILE`

This optional environment variable specifies the path to the SSL certificate. The certificate file must contain both the private and public key. This is typically a binary file with structure PKCS#12 (.p12). If this environment variable is set then either `TRANSBASE_CERTIFICATE_PASSWORD` or `TRANSBASE_CERTIFICATE_PASSWORD_FILE` must be set too.

**Important note:** Transbase tries to verify the `common name` field in the certificate. If you run this image and the common name in the certificate does not match the hostname, then Transbase won't start. The hostname can be set with parameter `--hostname <hostname>`.

```console
docker run -d \
    ...
    -e TRANSBASE_CERTIFICATE_FILE=/transbase/www.my-transbase.com.p12 \
    -e TRANSBASE_CERTIFICATE_PASSWORD=secretcertificatepassword \
    --hostname www.my-transbase.com \
    transbase
```

### `TRANSBASE_CERTIFICATE_PASSWORD`, `TRANSBASE_CERTIFICATE_PASSWORD_FILE`

These environment variables set the password of the certificate. `TRANSBASE_CERTIFICATE_PASSWORD` contains the password in plain text whereas `TRANSBASE_CERTIFICATE_PASSWORD_FILE` specifies a file which contains the password of the certificate. Generally this variable is used to load the password from Docker secrets which are stored under `/run/secrets`.

### `TRANSBASE_DATABASE_HOME`

This optional variable can be used to define another location for the database files. The default is `/transbase/databases`.

For example:

```console
docker run -d \
    ...
    -e TRANSBASE_DATABASE_HOME=/transbase/dbs
    transbase
```

## Docker Volumes

Docker Volumes are used for persisting data outside of Docker containers. By default an anonymous volume is created for all database files which are stored in the `TRANSBASE_DATABASE_HOME` directory. The default location therefor is `/transbase/databases`. You can specify an external volume with the `-v` or `--mount` flag. 

For example:

```console
docker run -d \
    ...
    -v transbase-volume:/transbase/databases \
    transbase
```

## Docker Secrets

Docker Secrets can be used to manage any sensitive data which a container needs at runtime. Therefor Transbase offers some environment variables with suffix `_FILE` to load sensitive data from files stored in `/run/secrets`.

Example `docker-compose.yaml`:

```yaml
version: "3.7"

services:
  my-transbase:
    image: transbase
    hostname: www.my-transbase.com
    restart: always
    ports:
      - 2024:2024
    environment:
      TRANSBASE_LICENSE_FILE: /run/secrets/tblic.ini
      TRANSBASE_PASSWORD_FILE: /run/secrets/admin.pwd
      TRANSBASE_CERTIFICATE_FILE: /run/secrets/www.my-transbase.com.p12
      TRANSBASE_CERTIFICATE_PASSWORD_FILE: /run/secrets/www.my-transbase.com.pwd
    secrets:
      - tblic.ini
      - admin.pwd
      - www.my-transbase.com.p12
      - www.my-transbase.com.pwd
    ...
```

# License

View [Transaction Software GmbH EULA](https://www.transaction.de/en/transbase/eula.html) and [Third Party Licenses](https://www.transaction.de/transbase/third-party.html) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.