#
# Debian with tools for java-native-interface development.
#
# Usage:
#
#   IMG=debian-jni:latest
#   CNTNR=debian-jni
#   curl -sSL "https://git.hiddenalpha.ch/dotfiles.git/plain/src/dockerfiles/debian-jni.Dockerfile" | sudo docker build . -f - -t "${IMG:?}"
#   sudo docker container create --name "${CNTNR:?}" -v "${PWD:?}:/work" "${IMG:?}"
#   sudo docker start "${CNTNR:?}"
#   sudo docker exec -ti "${CNTNR:?}" bash
#

ARG PARENT_IMAGE=debian:buster-20220622-slim
FROM $PARENT_IMAGE

ENV \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

RUN true \
    && apt update \
    && apt install -y --no-install-recommends \
         g++ make openjdk-11-jdk-headless \
    && apt clean \
    && true

USER 1000:1000
WORKDIR /work
CMD ["sleep", "36000"]
