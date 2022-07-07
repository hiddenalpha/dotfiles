#
# Debian with C++ compiler.
#
# CNTNRNAME=debian-cxx
# sudo docker build . -f THIS_FILE
# IMG=
# sudo docker container create --name $CNTNRNAME -v "$PWD:/work" $IMG
# sudo docker start $CNTNRNAME
# sudo docker exec -ti $CNTNRNAME bash
#
FROM debian:buster-20220622-slim

RUN true \
    && PGKINIT="apt update" \
    && PKGCLEAN="apt clean" \
    && PKGADD="apt install -y --no-install-recommends" \
    && $PGKINIT \
    && $PKGADD bash g++ make vim tar \
    && $PKGCLEAN \
    && true

USER 1000:1000
WORKDIR /work
CMD ["sleep", "36000"]
