FROM ubuntu:22.04

ARG KAFKA_VERSION=2.8.2
ARG SCALA_VERSION=2.13
ARG KAFKA_BINARY_NAME="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
ARG KAFKA_BINARY_TAR_NAME="${KAFKA_BINARY_NAME}.tgz"
ARG KAFKA_BINARY_ASC_NAME="${KAFKA_BINARY_TAR_NAME}.asc"
ARG KAFKA_BINARY_URI="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_BINARY_TAR_NAME}"
ARG KAFKA_BINARY_ASC_URI="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_BINARY_ASC_NAME}"

RUN apt-get -qq update \
    && apt-get install -qq -y wget gpg gettext openjdk-8-jre

# install kafka
RUN wget -nv $KAFKA_BINARY_URI \
    && wget -nv $KAFKA_BINARY_ASC_URI \
    && wget -nv https://archive.apache.org/dist/kafka/KEYS \
    && gpg --import KEYS \
    && gpg --verify $KAFKA_BINARY_ASC_NAME $KAFKA_BINARY_TAR_NAME \
    && mkdir -p /opt/kafka \
    && tar xzf $KAFKA_BINARY_TAR_NAME -C /opt \
    && mv /opt/$KAFKA_BINARY_NAME/* /opt/kafka \
    && rm $KAFKA_BINARY_TAR_NAME $KAFKA_BINARY_ASC_NAME KEYS

WORKDIR "/opt/kafka/"
