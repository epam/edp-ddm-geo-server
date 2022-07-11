FROM tomcat:9.0.64-jre8

RUN apt-get update && apt-get -y install unzip wget
RUN wget -q http://sourceforge.net/projects/geoserver/files/GeoServer/2.20.5/geoserver-2.20.5-war.zip -O /tmp/geoserver.zip
RUN unzip -q /tmp/geoserver.zip -d /tmp
RUN mv /tmp/geoserver.war /usr/local/tomcat/webapps/geoserver.war