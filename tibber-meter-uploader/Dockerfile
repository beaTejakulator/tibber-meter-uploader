ARG BUILD_FROM
FROM $BUILD_FROM

# Setting up the environment
ENV DRY_RUN=false
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-armhf
ENV PATH=$JAVA_HOME/bin:$PATH
ENV LANG=C.UTF-8
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

RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jdk ca-certificates curl jq bash && \
    rm -rf /var/lib/apt/lists/* # buildkit

RUN addgroup --system myapp && adduser --system --ingroup myapp myapp

RUN mkdir -p /opt/myapp && chown -R myapp:myapp /opt/myapp

WORKDIR /opt/myapp

COPY src/main/target/tibber-meter-uploader-1.0.0-SNAPSHOT.jar /opt/myapp/tibber-meter-uploader-1.0.0-SNAPSHOT.jar

COPY run.sh /
RUN chmod a+x /run.sh

USER myapp

CMD ["/run.sh"]
