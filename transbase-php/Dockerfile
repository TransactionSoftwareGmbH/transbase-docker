FROM php:7.2.8-fpm-alpine3.7

# TODO: fetch from transbase server?
COPY ./transbase-so/php-7.2-nts_transbase-8_v2.2.1_linux-x86_64.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/php_transbase.so
COPY ./transbase-so/libtci.so /lib/libtci.so

ADD php.ini /usr/local/etc/php