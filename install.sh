#!/bin/bash
ADDRESS_FILE=$PWD
#是否安装nginx  0=安装 1=不安装
NGINX_INSTALL=0

#是否安装mysql  0=安装 1=不安装
MYSQL_INSTALL=0

#是否安装php  0=安装 1=不安装
PHP_INSTALL=0

#是否安装redis  0=安装 1=不安装
REDIS_INSTALL=0

#默认mysql端口  
DEFAULT_MYSQL_PORT=3306
CONFIG_MYSQL_PORT=$DEFAULT_MYSQL_PORT

#默认mysql超级账户
DEFAULT_MYSQL_DEFAULT_USER='root'
CONFIG_MYSQL_DEFAULT_USER=$DEFAULT_MYSQL_DEFAULT_USER

#默认mysql超级密码
DEFAULT_MYSQL_DEFAULT_PASSWORD='root'
CONFIG_MYSQL_DEFAULT_PASSWORD=$DEFAULT_MYSQL_DEFAULT_PASSWORD

#判断是否设置项目账户密码  0=是 1=否
DEFAULT_USER_PROJECT_STATUS=1
CONFIG_USER_PROJECT_STATUS=$DEFAULT_USER_PROJECT_STATUS

#项目数据库
DEFAULT_MYSQL_DBNAME='test'
CONFIG_MYSQL_DBNAME=$DEFAULT_MYSQL_DBNAME

#项目访问mysql账户
DEFAULT_MYSQL_USERNAME='user'
CONFIG_MYSQL_USERNAME=$DEFAULT_MYSQL_USERNAME

#项目访问mysql密码
DEFAULT_MYSQL_PASSWORD='user'
CONFIG_MYSQL_PASSWORD=$DEFAULT_MYSQL_PASSWORD

#判断是否导入项目sql文件
DEFAULT_IMPORT_SQL_STATUS=1
CONFIG_IMPORT_SQL_STATUS=$DEFAULT_IMPORT_SQL_STATUS

#项目导入sql文件
DEFAULT_IMPORT_SQL=$ADDRESS_FILE'/test.sql'
CONFIG_IMPORT_SQL=$DEFAULT_IMPORT_SQL

#默认redis端口
DEFAULT_REDIS_PORT=6379
CONFIG_REDIS_PORT=$DEFAULT_REDIS_PORT

#默认redis密码
DEFAULT_REDIS_PASSWORD='123456'
CONFIG_REDIS_PASSWORD=$DEFAULT_REDIS_PASSWORD

#默认redis开放地址
DEFAULT_REDIS_ADDRESS='127.0.0.1'
CONFIG_REDIS_ADDRESS=$DEFAULT_REDIS_ADDRESS

echo "需要安装nginx？"
read -p "请选择（0=安装 1=不安装，默认：$NGINX_INSTALL）: " NGINX_INSTALL
echo ""
echo " 需要安装mysql?"
read -p "请选择（0=安装 1=不安装，默认：$MYSQL_INSTALL）: " MYSQL_INSTALL
echo " "
if [[ $MYSQL_INSTALL -eq 0 ]]; then
    read -p "请设置mysql端口（默认：$DEFAULT_MYSQL_PORT）: " DEFAULT_MYSQL_PORT
    DEFAULT_MYSQL_PORT=${DEFAULT_MYSQL_PORT:-$CONFIG_MYSQL_PORT}
    echo " "
    read -p "请设置mysql超级账户名（默认：$DEFAULT_MYSQL_DEFAULT_USER）: " DEFAULT_MYSQL_DEFAULT_USER
    DEFAULT_MYSQL_DEFAULT_USER=${DEFAULT_MYSQL_DEFAULT_USER:-$CONFIG_MYSQL_DEFAULT_USER}
    echo " "
    #默认密码
    read -p "请设置mysql超级账户密码（默认：$DEFAULT_MYSQL_DEFAULT_PASSWORD）: " DEFAULT_MYSQL_DEFAULT_PASSWORD
    DEFAULT_MYSQL_DEFAULT_PASSWORD=${DEFAULT_MYSQL_DEFAULT_PASSWORD:-$CONFIG_MYSQL_DEFAULT_PASSWORD}
    echo " "
    echo "是否项目数据库及账户密码？"
    read -p "请选择（0=是 1=否，默认：$DEFAULT_USER_PROJECT_STATUS）: " DEFAULT_USER_PROJECT_STATUS
    DEFAULT_USER_PROJECT_STATUS=${DEFAULT_USER_PROJECT_STATUS:-$CONFIG_USER_PROJECT_STATUS}
    echo " "
    if [[ $DEFAULT_USER_PROJECT_STATUS -eq 0 ]]; then
        #项目数据库
        read -p "请设置项目数据库（默认：$DEFAULT_MYSQL_DBNAME）: " DEFAULT_MYSQL_DBNAME
        DEFAULT_MYSQL_DBNAME=${DEFAULT_MYSQL_DBNAME:-$CONFIG_MYSQL_DBNAME}
        echo " "
        #项目账户
        read -p "请设置项目访问数据库账户（默认：$DEFAULT_MYSQL_USERNAME）: " DEFAULT_MYSQL_USERNAME
        DEFAULT_MYSQL_USERNAME=${DEFAULT_MYSQL_USERNAME:-$CONFIG_MYSQL_USERNAME}
        echo " "
        #项目密码
        read -p "请设置项目访问数据库密码（默认：$DEFAULT_MYSQL_PASSWORD）: " DEFAULT_MYSQL_PASSWORD
        DEFAULT_MYSQL_PASSWORD=${DEFAULT_MYSQL_PASSWORD:-$CONFIG_MYSQL_PASSWORD}
        echo " "
        #判断是否导入项目sql文件
        echo "是否导入项目sql文件？"
        read -p "请选择（0=导入 1=不导入，默认：$DEFAULT_IMPORT_SQL_STATUS）: " DEFAULT_IMPORT_SQL_STATUS
        DEFAULT_IMPORT_SQL_STATUS=${DEFAULT_IMPORT_SQL_STATUS:-$CONFIG_IMPORT_SQL_STATUS}
        echo " "
        if [[ $DEFAULT_IMPORT_SQL_STATUS -eq 0 ]]; then
            #项目导入sql文件
            read -p "请设置项目导入sql文件地址（默认：$DEFAULT_IMPORT_SQL）: " DEFAULT_IMPORT_SQL
            DEFAULT_IMPORT_SQL=${DEFAULT_IMPORT_SQL:-$CONFIG_IMPORT_SQL}
        fi
    fi
fi
echo ""
echo " 需要安装php?"
read -p "请选择（0=安装 1=不安装，默认：$PHP_INSTALL）: " PHP_INSTALL
echo ""
echo " 需要安装redis?"
read -p "请选择（0=安装 1=不安装，默认：$REDIS_INSTALL）: " REDIS_INSTALL
echo " "
if [[ $REDIS_INSTALL -eq 0 ]]; then
    #默认端口
    read -p "请设置redis端口（默认：$DEFAULT_REDIS_PORT）: " DEFAULT_REDIS_PORT
    DEFAULT_REDIS_PORT=${DEFAULT_REDIS_PORT:-$CONFIG_REDIS_PORT}
    echo " "
    #默认密码
    read -p "请设置redis密码（默认：$DEFAULT_REDIS_PASSWORD）: " DEFAULT_REDIS_PASSWORD
    DEFAULT_REDIS_PASSWORD=${DEFAULT_REDIS_PASSWORD:-$CONFIG_REDIS_PASSWORD}
    echo " "
    #默认开放地址
    read -p "请设置redis开放地址（默认：$DEFAULT_REDIS_ADDRESS）: " DEFAULT_REDIS_ADDRESS
    DEFAULT_REDIS_ADDRESS=${DEFAULT_REDIS_ADDRESS:-$CONFIG_REDIS_ADDRESS}
fi


INSTALL_INFO='安装完成\n'

if [[ $NGINX_INSTALL -eq 0 ]]; then
    #执行nginx
    . $ADDRESS_FILE/nginx.sh
fi

if [[ $MYSQL_INSTALL -eq 0 ]]; then
    if [[ $DEFAULT_USER_PROJECT_STATUS -eq 0 ]]; then
        if [[ $IMPORT_SQL_STATUS -eq 0 ]]; then
            . $ADDRESS_FILE/mysql.sh $DEFAULT_MYSQL_PORT $DEFAULT_MYSQL_DEFAULT_USER $DEFAULT_MYSQL_DEFAULT_PASSWORD $DEFAULT_USER_PROJECT_STATUS $DEFAULT_MYSQL_DBNAME $DEFAULT_MYSQL_USERNAME $DEFAULT_MYSQL_PASSWORD $DEFAULT_IMPORT_SQL_STATUS $DEFAULT_IMPORT_SQL
        else
            #执行MySQL
            . $ADDRESS_FILE/mysql.sh $DEFAULT_MYSQL_PORT $DEFAULT_MYSQL_DEFAULT_USER $DEFAULT_MYSQL_DEFAULT_PASSWORD $DEFAULT_USER_PROJECT_STATUS $DEFAULT_MYSQL_DBNAME $DEFAULT_MYSQL_USERNAME $DEFAULT_MYSQL_PASSWORD $DEFAULT_IMPORT_SQL_STATUS
        fi
    else
        #执行MySQL
        . $ADDRESS_FILE/mysql.sh $DEFAULT_MYSQL_PORT $DEFAULT_MYSQL_DEFAULT_USER $DEFAULT_MYSQL_DEFAULT_PASSWORD $DEFAULT_USER_PROJECT_STATUS
    fi
fi

if [[ $PHP_INSTALL -eq 0 ]]; then
    #执行php
    . $ADDRESS_FILE/php.sh
fi

if [[ $REDIS_INSTALL -eq 0 ]]; then
    #执行redis
    . $ADDRESS_FILE/redis.sh $DEFAULT_REDIS_PORT $DEFAULT_REDIS_PASSWORD $DEFAULT_REDIS_ADDRESS
fi

echo -e $INSTALL_INFO
