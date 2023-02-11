# psql

A simple image to run PostgreSQL jobs for multiple architectures (including Raspberry Pi) using ```psql```, the PostgreSQL interactive terminal.

This is the image source code for the [greuceanu/psql](https://hub.docker.com/r/greuceanu/psql) repository.

## Usage

### Examples

#### Simple _psql_ call

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pgsql-init-sql
  namespace: db
spec:
  template:
    spec:
      containers:
        - name: pgsql-init-sql
          image: greuceanu/psql
          env:
            - name: PSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: some-secret
                  key: some-key
            - name: NEW_USER_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: some-secret
                  key: some-other-key
          command:
            - sh
            - -c
            - |
              psql "host=pgsql user=postgres password=$PSQL_PASSWORD" <<EOF
              IF NOT EXISTS (SELECT * FROM pg_roles WHERE rolname='newuser') THEN
                CREATE USER newuser WITH PASSWORD '$NEW_USER_PASSWORD';
              END IF;
      restartPolicy: Never
  backoffLimit: 4
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
