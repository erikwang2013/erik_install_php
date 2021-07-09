#!/bin/bash

MYSQL_HOSTNAME=127.0.0.1

#默认mysql端口  
MYSQL_PORT=$1

#默认mysql超级账户
MYSQL_DEFAULT_USER=$2

#默认mysql超级密码
MYSQL_DEFAULT_PASSWORD=$3

#判断是否设置项目账户密码  0=是 1=否
USER_PROJECT_STATUS=$4

#项目数据库
MYSQL_DBNAME=$5

#项目访问mysql账户
MYSQL_USERNAME=$6

#项目访问mysql密码
MYSQL_PASSWORD=$7

#判断是否导入项目sql文件
IMPORT_SQL_STATUS=$8

#项目导入sql文件
IMPORT_SQL=$9

echo -e ""
echo "============================="
echo "复制mysql服务文件"
echo "============================="
echo -e ""
sleep 1s
\cp -rf $ADDRESS_FILE/etc/init.d/mysql /etc/init.d/
\cp -rf $ADDRESS_FILE/etc/my.cnf /etc/
\cp -rf $ADDRESS_FILE/etc/systemd/system/mysql.service /etc/systemd/system/
\cp -rf $ADDRESS_FILE/usr/local/mysql /usr/local/
\cp -rf $ADDRESS_FILE/usr/lib64/libexpect5.45.so /usr/lib64/
\cp -rf $ADDRESS_FILE/usr/lib64/libtcl8.5.so /usr/lib64/
\cp -rf $ADDRESS_FILE/usr/share/tcl8 /usr/share/
\cp -rf $ADDRESS_FILE/usr/share/tcl8.5 /usr/share/
\cp -rf $ADDRESS_FILE/usr/bin/expect /usr/bin/
\cp -rf $ADDRESS_FILE/var/log/mysqld.log /var/log/
echo -e ""
echo "============================="
echo "mysql服务文件复制完成"
echo "============================="
echo -e ""
sleep 1s
echo -e ""
echo "============================="
echo "创建mysql用户组"
echo "============================="
echo -e ""
sleep 1s
groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql
echo -e ""
echo "============================="
echo "mysql用户组创建完成"
echo "============================="
echo -e ""
sleep 1s
echo -e ""
echo "============================="
echo "创建mysql目录"
echo "============================="
echo -e ""
sleep 1s
mkdir -p /var/run/mysql /var/lib/mysql/client
echo -e ""
echo "============================="
echo "mysql目录创建完成"
echo "============================="
sleep 1s
echo -e ""
echo "============================="
echo "给mysql目录和程序添加权限"
echo "============================="
echo -e ""
sleep 1s
chmod a+x /etc/init.d/mysql /etc/systemd/system/mysql.service
chmod -R 777 /var/log/mysqld.log /var/run/mysql /var/lib/mysql /usr/local/mysql/data
echo -e ""
echo "============================="
echo "mysql权限添加完成";
echo "============================="
echo -e ""
ln -s /usr/local/mysql/bin/mysql /usr/local/bin/mysql
sleep 1s
echo -e ""
echo "============================="
echo "初始化mysql"
echo "============================="
echo -e ""
sleep 1s
/usr/local/mysql/bin/mysqld --initialize-insecure --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql
echo -e ""
echo "============================="
echo "初始化mysql完成";
echo "============================="
echo -e ""
echo "============================="
echo "启动mysql服务,初始化超级账户密码"
echo "============================="
echo -e ""
sleep 1s
#/etc/init.d/mysql start
systemctl daemon-reload
systemctl start mysql
systemctl enable mysql
sleep 3s
#chmod +x /usr/local/mysql/mysql_secure_installation.exp
#/usr/local/mysql/mysql_secure_installation.exp $MYSQL_DEFAULT_PASSWORD
root_grant="use mysql;update user set authentication_string=password('$MYSQL_DEFAULT_PASSWORD') where user='$MYSQL_DEFAULT_USER';"
/usr/local/bin/mysql  -P${MYSQL_PORT}  -u${MYSQL_DEFAULT_USER} -e "${root_grant}"
systemctl restart mysql
sleep 10s
echo -e "" 
echo "============================="
echo "mysql服务已启动"
echo "============================="
echo -e ""
if [[ $USER_PROJECT_STATUS -eq 0 ]]; then
    sleep 1s
    echo -e ""
    echo "============================="
    echo "设置项目的mysql账户及密码"
    echo "============================="
    echo -e ""
    sleep 1s
    grant="use mysql;grant all privileges on ${MYSQL_DBNAME}.* to ${MYSQL_USERNAME}@'%' identified by '${MYSQL_PASSWORD}';flush privileges;"
    /usr/local/bin/mysql  -P${MYSQL_PORT}  -u${MYSQL_DEFAULT_USER} -p${MYSQL_DEFAULT_PASSWORD} -e "${grant}"
    systemctl restart mysql
    sleep 10s
    #/etc/init.d/mysql stop
    #/etc/init.d/mysql start
    echo -e ""
    echo "============================="
    echo "项目的mysql账户及密码已设置完成"
    echo "============================="
    echo -e ""
    sleep 1s
    if [[ $IMPORT_SQL_STATUS -eq 0 ]]; then
        echo -e ""
        echo "============================="
        echo "导入sql文件至$MYSQL_DBNAME"
        echo "============================="
        echo -e ""
        sleep 1s
        create_db_sql="create database ${MYSQL_DBNAME} character set utf8 collate utf8_general_ci;"
        /usr/local/bin/mysql  -P${MYSQL_PORT}  -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -e "${create_db_sql}"
        install_sql="use ${MYSQL_DBNAME};source ${IMPORT_SQL};"
        /usr/local/bin/mysql  -P${MYSQL_PORT}  -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -e "${install_sql}"
        echo -e ""
        echo "============================="
        echo "sql导入完成";
        echo "============================="
    fi
fi

#/etc/init.d/mysql stop

INSTALL_INFO=$INSTALL_INFO"mysql超级账户：$MYSQL_DEFAULT_USER\nmysql超级账户密码：$MYSQL_DEFAULT_PASSWORD\n"
if [[ $USER_PROJECT_STATUS -eq 0 ]]; then
    INSTALL_INFO=$INSTALL_INFO"项目数据库名：$MYSQL_DBNAME\n"
    INSTALL_INFO=$INSTALL_INFO"项目数据库账户：$MYSQL_USERNAME\n项目数据库账户密码：$MYSQL_PASSWORD\n"
    if [[ $IMPORT_SQL_STATUS -eq 0 ]]; then
        INSTALL_INFO=$INSTALL_INFO"导入的项目sql地址：$IMPORT_SQL\n"
    fi
fi
INSTALL_INFO=$INSTALL_INFO"mysql连接地址：$MYSQL_HOSTNAME\nmysql端口：$MYSQL_PORT\n"
INSTALL_INFO=$INSTALL_INFO"mysql版本：5.7.30\n\n"