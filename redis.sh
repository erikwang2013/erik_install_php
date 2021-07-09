#!/bin/bash
#默认redis端口
REDIS_PORT=$1

#默认redis密码
REDIS_PASSWORD=$2

#默认redis开放地址
REDIS_ADDRESS=$3
echo -e ""
echo "============================="
echo "复制程序到指定目录"
echo "============================="
echo -e ""
sleep 1s
echo -e ""
echo "============================="
echo "正在复制中……"
echo "============================="
echo -e ""
chmod -R 777 $ADDRESS_FILE
\cp -rf $ADDRESS_FILE/etc/init.d/redis /etc/init.d/
echo -e ""
echo "============================="
echo "服务程序文件已复制成功，开始复制扩展及配置文件"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/etc/systemd/system/redis.service /etc/systemd/system/
echo -e ""
echo "============================="
echo "扩展及配置文件已复制成功，开始复制主程序"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/usr/local/redis /usr/local/
echo -e ""
echo "============================="
echo "主程序已复制成功"
echo "============================="
echo -e ""
echo "============================="
echo "给目录和程序添加权限"
echo "============================="
echo -e ""
sleep 1s
chmod a+x /etc/init.d/redis /etc/systemd/system/redis.service
echo -e ""
echo "============================="
echo "权限添加完成";
echo "============================="
echo -e ""
sleep 1s
systemctl daemon-reload
echo -e ""
echo "============================="
echo "启动redis服务"
echo "============================="
echo -e ""
sleep 1s
systemctl start redis
echo -e ""
echo "============================="
echo "redis服务已启动"
echo "============================="
echo -e ""
sleep 1s
systemctl enable redis
ln -s /usr/local/redis/bin/redis /usr/local/bin/redis
echo -e ""
sed -i "/# bind 127.0.0.1/i\bind $REDIS_ADDRESS" /usr/local/redis/etc/redis.conf #配置只有本地才可以访问
sed -i "/# requirepass foobared/i\requirepass $REDIS_PASSWORD" /usr/local/redis/etc/redis.conf #配置只有本地才可以访问
systemctl restart redis
echo "==="$REDIS_PORT
INSTALL_INFO=$INSTALL_INFO"redis服务端口：$REDIS_PORT\nredis开放地址：$REDIS_ADDRESS\nredis密码：$REDIS_PASSWORD\nredis版本：2.8.19\n"