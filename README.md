# psql

A simple and lightweight image to run PostgreSQL jobs which can be build for multiple architectures
(including for RaspberryPi) using ```psql``` - the PostgreSQL interactive terminal.

This is the image source code for the [greuceanu/psql](https://hub.docker.com/r/greuceanu/psql) repository.

## Usage

As you want - don't forget to specify the command/entrypoint (check examples).

### Examples

#### Simple _psql_ call for _k8s_

Assumes that config map, secrets and deployment objects are already created:

```yaml
---
#
# Job which runs init script
#
apiVersion: batch/v1
kind: Job
metadata:
  name: pgsql-init-sql
  namespace: ns
spec:
  template:
    spec:
      volumes:
      - name: init-sql
        configMap:
          name: pgsql-config
      containers:
      - name: pgsql-create-users
        image: greuceanu/psql:latest
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: pgsql-secrets
              key: POSTGRES_PASSWORD
        - name: PGUACD_PASSWORD
          valueFrom:
            secretKeyRef:
              name: pgsql-secrets
              key: PGUACD_PASSWORD
        command:
        - sh
        - -c
        - |
          until pg_isready -h pgsql -U postgres; do
            sleep 1
          done
          psql "host=pgsql user=postgres password=$POSTGRES_PASSWORD" -f /mnt/init.sql
        volumeMounts:
        - name: init-sql
          mountPath: /mnt
      restartPolicy: OnFailure
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
