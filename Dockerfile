FROM alpine:3.13

LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"

EXPOSE 9000

RUN apk update && apk add --no-cache php8 php8-pdo php8-fpm php8-pdo_pgsql php8-pdo_mysql ca-certificates && update-ca-certificates 
           
RUN ln -s /usr/bin/php8 /usr/bin/php && \
    sed -i '/^;error_log = /c error_log = /proc/self/fd/2' /etc/php8/php-fpm.conf && \
    sed -i '/^listen = /c listen = 9000' /etc/php8/php-fpm.d/www.conf && \
	sed -i '/^;catch_workers_output /c catch_workers_output = yes' /etc/php8/php-fpm.d/www.conf 
 
CMD ["php-fpm8", "--allow-to-run-as-root", "--nodaemonize"]
