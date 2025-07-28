FROM phzfi/debian:bookworm-latest

#Note! Webroot is at /var/www/html, but let's install composer files etc one dir above
WORKDIR /var/www

ADD scripts/provision.sh /opt
ADD tests/* /opt/

RUN /opt/provision.sh

COPY etc/ /etc

USER www-data

# daemon must be disabled so the container won't exit immediately
CMD ["/usr/sbin/php-fpm8.2", "--fpm-config", "/etc/php/8.2/fpm/php-fpm.conf"]
