# psql

PostgreSQL interactive terminal Docker image with ```psql```.

## Building

### Local

```bash
docker build . -t psql:latest
```

### ARMv7

```bash
docker buildx build .
# or
docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 --build-arg ALPINE_VERSION=latest . 
```
