FROM php:7.2.13-fpm-alpine3.8

ENV SSH_PORT 2222

RUN apk add --update openssh supervisor \
&& rm  -rf /tmp/* /var/cache/apk/*
RUN mkdir -p /var/run/sshd /var/log/supervisor
RUN echo 'root:Docker!' | chpasswd

COPY sshd_config /etc/ssh/
ADD supervisord.conf /etc/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod -R +x /usr/local/bin

EXPOSE 2222

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
