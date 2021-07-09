#!/bin/bash

systemctl stop mysql
systemctl stop nginx
systemctl stop redis
systemctl stop php-fpm

pgrep -f mysql | sudo xargs kill -9 >/dev/null 2>&1
pgrep -f nginx | sudo xargs kill -9 >/dev/null 2>&1
pgrep -f redis | sudo xargs kill -9 >/dev/null 2>&1
pgrep -f php | sudo xargs kill -9 >/dev/null 2>&1

rm -rf /usr/local/mysql
rm -rf /usr/local/nginx
rm -rf /usr/local/php
rm -rf /usr/local/redis

rm -rf /usr/local/bin/redis
rm -rf /usr/local/bin/mysql
rm -rf /usr/local/bin/nginx
rm -rf /usr/local/bin/pecl
rm -rf /usr/local/bin/php
rm -rf /usr/local/bin/php-config
rm -rf /usr/local/bin/phpize


rm -rf /etc/my.cnf
rm -rf /etc/init.d/nginx
rm -rf /etc/init.d/redis
rm -rf /etc/init.d/mysql
rm -rf /etc/init.d/php-fpm

rm -rf /etc/systemd/system/mysql.service
rm -rf /etc/systemd/system/nginx.service
rm -rf /etc/systemd/system/php-fpm.service
rm -rf /etc/systemd/system/redis.service
rm -rf /etc/systemd/system/multi-user.target.wants/mysql.service
rm -rf /etc/systemd/system/multi-user.target.wants/nginx.service
rm -rf /etc/systemd/system/multi-user.target.wants/php-fpm.service
rm -rf /etc/systemd/system/multi-user.target.wants/redis.service

rm -rf /usr/bin/expect
rm -rf /usr/share/tcl8
rm -rf /usr/share/tcl8.5

rm -rf /usr/lib64/libexpect5.45.so
rm -rf /usr/lib64/libjpeg.so.62
rm -rf /usr/lib64/libpng15.so.15
rm -rf /usr/lib64/libtcl8.5.so

rm -rf /var/lib/mysql
rm -rf /var/log/mysqld.log
rm -rf /var/run/tmp/nginx
rm -rf /var/run/mysql

echo -e "卸载完成"
exit