#!/bin/bash

# Laden der Bashio-Funktionen
source /usr/lib/hassio-addons/bashio

# Lesen der Konfigurationsoptionen aus options.json
TIBBER_LOGIN=$(bashio::config 'tibber_login')
TIBBER_PASSWORD=$(bashio::config 'tibber_password')

# Verwendung der Konfigurationsoptionen in Ihrem Add-On
echo "TIBBER_LOGIN: $TIBBER_LOGIN"
echo "TIBBER_PASSWORD: $TIBBER_PASSWORD"

# Ausführen Ihrer Java-Anwendung
java -jar /opt/myapp/tibber-meter-uploader-1.0.0-SNAPSHOT.jar
