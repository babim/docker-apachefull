FROM babim/ubuntubase

RUN apt-get update && \
    apt-get install apache2 libapache2-mod-fcgid -y --force-yes && a2enmod proxy proxy_fcgi && a2enmod rewrite && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/** && \
    a2enmod headers

# Define mountable directories.
VOLUME ["/var/log/apache2", "/var/www", "/etc/apache2/sites-available/", "/etc/apache2/sites-enabled"]
RUN mkdir -p /etc-start/apache2/sites-available && mkdir -p /etc-start/apache2/sites-enabled && \
    cp -R /etc/apache2/sites-available/* /etc-start/apache2/sites-available && \
    cp -R /etc/apache2/sites-enabled/* /etc-start/apache2/sites-enabled

EXPOSE 80 443
ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD ["/start.sh"]
