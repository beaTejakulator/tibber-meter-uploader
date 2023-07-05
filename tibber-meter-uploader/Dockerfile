#FROM debian:latest
ARG BUILD_FROM
FROM $BUILD_FROM

# Setting up the environment
ENV DRY_RUN=false
ENV JAVA_HOME=/usr/local/openjdk-11
ENV PATH=$JAVA_HOME/bin:$PATH
ENV LANG=C.UTF-8
ENV JAVA_VERSION=11.0.2+9
ENV READINGS_SCRIPT_COMMAND=/config/tibber_uploader/read_meter.sh
ENV READINGS_SOURCE_CLASS=ScriptedRestApiMeterReadingSource
ENV TIBBER_METER_REGISTER_ID=1-1:1.8.0
ENV TZ=Europe/Berlin
# ENV TIBBER_LOGIN=
# ENV TIBBER_PASSWORD=

COPY src/main/resources/read_meter.sh /opt/myapp/read_meter.sh
RUN chmod +x /opt/myapp/read_meter.sh

COPY run.sh /opt/myapp/run.sh
RUN chmod a+x /opt/myapp/run.sh

RUN set -eux; \
    apk update; \
    apk add --no-cache ca-certificates p11-kit curl ; \
    arch="$(apk --print-arch)"; \
    case "$arch" in \
    'x86_64') \
    downloadUrl='https://github.com/adoptopenjdk/openjdk11-binaries/releases/download/jdk-11.0.2%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz'; \
    ;; \
    'aarch64') \
    downloadUrl='https://github.com/adoptopenjdk/openjdk11-binaries/releases/download/jdk-11.0.2%2B9/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.2_9.tar.gz'; \
    ;; \
    *) echo >&2 "error: unsupported architecture: '$arch'"; exit 1 ;; \
    esac; \
    curl -Lso openjdk.tgz "$downloadUrl"; \
    mkdir -p "$JAVA_HOME"; \
    tar --extract --file openjdk.tgz --directory "$JAVA_HOME" --strip-components 1 --no-same-owner ; \
    rm openjdk.tgz*; \
    apk del curl; \
    javac --version; \
    java --version

RUN apk update && apk add --no-cache curl jq bash # buildkit

RUN addgroup -S myapp && adduser -S -G myapp myapp

RUN mkdir -p /opt/myapp && chown -R myapp:myapp /opt/myapp

WORKDIR /opt/myapp

COPY src/main/target/tibber-meter-uploader-1.0.0-SNAPSHOT.jar /opt/myapp/tibber-meter-uploader-1.0.0-SNAPSHOT.jar

USER myapp

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
