#
# Debian with C++ compiler.
#
# Usage:
#
#   IMG=debian-cxx:latest
#   CNTNR=debian-cxx
#   curl -sSL "https://git.hiddenalpha.ch/dotfiles.git/plain/src/dockerfiles/debian-cxx.Dockerfile" | sudo docker build . -f - -t "${IMG:?}"
#   sudo docker container create --name "${CNTNR:?}" -v "${PWD:?}:/work" "${IMG:?}"
#   sudo docker start "${CNTNR:?}"
#   sudo docker exec -ti "${CNTNR:?}" bash
#

ARG PARENT_IMAGE=debian:buster-20220622-slim
FROM $PARENT_IMAGE

RUN true \
    && apt update \
    && apt install -y --no-install-recommends \
         g++ make \
    && apt clean \
    && true

USER 1000:1000
WORKDIR /work
CMD ["sleep", "36000"]
