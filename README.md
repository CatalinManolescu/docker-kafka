# Apache Kafka

Resources:

- <https://kafka.apache.org/downloads>

## Build

```shell
KAFKA_VERSION=3.2.3
SCALA_VERSION=2.12
docker buildx build --platform linux/amd64,linux/arm64 \
  --build-arg KAFKA_VERSION=${KAFKA_VERSION} \
  --build-arg SCALA_VERSION=${SCALA_VERSION} \
  -t catalinm/kafka:${SCALA_VERSION}-${KAFKA_VERSION} --push .
```