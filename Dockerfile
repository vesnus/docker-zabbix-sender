FROM python:2.7-onbuild
MAINTAINER Tristan CAREL <tristan.carel@gmail.com>

# ONBUILD directives took care of uploading
# the code and install dependencies

# Install zabbix_sender utility
RUN apt-get update && apt-get install -y zabbix-agent && apt-get clean

# Install module
RUN pip install .

# REQUIRED INPUTS

# Hostname or IP address of Zabbix server
ENV ZABBIX_SERVER zabbix-server

# Specify hostname of Zabbix events dedicated to the daemon
# May be the FQDN or host running this container.
ENV ZABBIX_HOST daemon.localdomain

# Container needs to access the socket on host
VOLUME /var/run/docker.sock

CMD "docker-zabbix-sender"
