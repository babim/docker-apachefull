FROM babim/ubuntubase:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Download option
RUN apt-get update && \
    apt-get install -y wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

RUN apt-get install software-properties-common inetutils-ping -y

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/start.sh"]
CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]
