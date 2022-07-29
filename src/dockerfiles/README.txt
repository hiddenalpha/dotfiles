
How to use Dockerfiles
======================

## Some basic commands

sudo docker build . -f DOCKERFILE -t IMG

sudo docker run --rm -ti "${IMG:?}" sh
sudo docker run --rm -i img-name sh --help

sudo docker create --name CNTNR "${IMG:?}"
sudo docker start "${CNTNR:?}"
sudo docker exec -ti "${CNTNR:?}" sh


## X11 app within container using host display

sudo docker create --name "${CNTNR:?}" -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro "${IMG:?}"


