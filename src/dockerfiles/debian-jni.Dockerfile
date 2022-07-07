#
# Debian with tools for java-native-interface development.
#
# CNTNRNAME=debian-cxx
# sudo docker build . -f THIS_FILE
# IMG=
# sudo docker container create --name $CNTNRNAME -v "$PWD:/work" $IMG
# sudo docker start $CNTNRNAME
# sudo docker exec -ti $CNTNRNAME bash
#
FROM debian:buster-20220622-slim

ENV \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

RUN true \
    && PGKINIT="apt update" \
    && PKGCLEAN="apt clean" \
    && PKGADD="apt install -y --no-install-recommends" \
    && $PGKINIT \
    && $PKGADD bash g++ file make openjdk-11-jdk-headless vim tar \
    && $PKGCLEAN \
    && true

USER 1000:1000
WORKDIR /work
CMD ["sleep", "36000"]
