# psql

A simple image to run PostgreSQL jobs for multiple architectures (including Raspberry Pi) using ```psql```, the PostgreSQL interactive terminal.

This is the image source code for the [greuceanu/psql](https://hub.docker.com/r/greuceanu/psql) repository.

## Usage

Make use of the following environment variables:

```dockerfile
## Single connection string - using this will ignore the rest of connection parameters
ENV PSQL_CONNECTION_STRING=
## Default input script file name script.sh
ENV PSQL_SCRIPT_FILE=script.sql
## SQL string to execute instead of script file
ENV PSQL_SCRIPT=
## DB host
ENV PSQL_HOST=
## DB post
ENV PSQL_PORT=
## DB SSL mode
ENV PSQL_SSLMODE=prefer
## DB user
ENV PSQL_USER=
## DB user password
ENV PSQL_PASSWORD=
## DB name
ENV PSQL_DBNAME=
```

Using ```PSQL_CONNECTION_STRING``` will ignore the other connection parameters: ```PSQL_HOST```, ```PSQL_PORT```,
```PSQL_SSLMODE```, ```PSQL_USER```, ```PSQL_PASSWORD``` and ```PSQL_DBNAME```.

### Examples

#### PostgreSQL deployment in k8s

The following example is highlighting use within Kubernetes deployment:

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pgsql
  namespace: ns
spec:
  replicas: 1
  selector:
    matchLabels:
      component: pgsql
  template:
    metadata:
      labels:
        component: pgsql
    spec:
      containers:
        - name: pgsql
          image: postgres
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: pgsql
                  key: PGPASSWORD
---

---
apiVersion: v1
kind: Secret
metadata:
  name: pgsql
  namespace: ns
type: Opaque
data:
  PGPASSWORD: XXX
```

## Building

### Local

```bash
docker build . -t psql:latest
```

### Other architectures (e.g. for Raspberry Pi)

First, make sure you can build for other architectures locally:

```bash
docker buildx create --name builder
docker buildx use builder
docker buildx inspect --bootstrap
```

Then, simply run the following:

```bash
docker buildx build --platform linux/amd64,linux/arm64,linux/386,linux/arm/v7,linux/arm/v6 --build-arg ALPINE_VERSION=latest -t greuceanu/psql:latest .
```
