FROM kartoza/geoserver:2.21.0
USER root:root
RUN mkdir /metrics-exporter
COPY ./files/ /metrics-exporter/
