#
#  IMG=alpine-mvn:latest
#  sudo docker build . -f - -t "${IMG:?}"
#  sudo docker run --rm -ti -v "$HOME/.m2/repo:/data/maven/.m2/repo" -v "$PWD:/work" "${IMG:?}" sh
#
ARG PARENT_IMAGE=alpine:3.16.0
FROM $PARENT_IMAGE

# openjdk8-jre
ARG PKGS_TO_ADD="maven"
ARG PKGS_TO_DEL=""
ARG PKGINIT="true"
ARG PKGADD="apk add"
ARG PKGDEL="true"
ARG PKGCLEAN="true"

WORKDIR /work

RUN true \
    && $PKGINIT \
    && $PKGADD $PKGS_TO_ADD \
    && sed -i "s,</settings>,  <localRepository>/data/maven/.m2/repo</localRepository>\n</settings>,g" /usr/share/java/maven-3/conf/settings.xml \
    && mkdir /data /data/maven \
    && chown 1000:1000 /data/maven \
    && chown 1000:1000 /work \
    && $PKGDEL $PKGS_TO_DEL \
    && $PKGCLEAN \
    && true

USER 1000:1000

RUN true \
    # Make maven download generic stuff to not download it over and over.
    && echo "<project>" > pom.xml \
    && echo "  <modelVersion>4.0.0</modelVersion>" >> pom.xml \
    && echo "  <groupId>com.example</groupId>" >> pom.xml \
    && echo "  <artifactId>example</artifactId>" >> pom.xml \
    && echo "  <version>0.0.0-SNAPSHOT</version>" >> pom.xml \
    && echo "  <properties>" >> pom.xml \
    && echo "    <maven.compiler.source>1.8</maven.compiler.source>" >> pom.xml \
    && echo "    <maven.compiler.target>1.8</maven.compiler.target>" >> pom.xml \
    && echo "  </properties>" >> pom.xml \
    && echo "</project>" >> pom.xml \
    && mvn clean verify \
    && rm -rf * \
    && true

CMD ["sleep", "36000"]

