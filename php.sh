#!/bin/bash
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
\cp -rf $ADDRESS_FILE/etc/init.d/php-fpm /etc/init.d/
echo -e ""
echo "============================="
echo "服务程序文件已复制成功，开始复制扩展及配置文件"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/etc/systemd/system/php-fpm.service /etc/systemd/system/
\cp -rf $ADDRESS_FILE/usr/lib64/* /usr/lib64/
echo -e ""
echo "============================="
echo "扩展及配置文件已复制成功，开始复制主程序"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/usr/local/php /usr/local/
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
chmod a+x /etc/init.d/php-fpm /etc/systemd/system/php-fpm.service
echo -e ""
echo "============================="
echo "权限添加完成";
echo "============================="
echo -e ""
sleep 1s
systemctl daemon-reload
echo -e ""
echo "============================="
echo "启动php服务"
echo "============================="
echo -e ""
sleep 1s
systemctl start php-fpm
echo -e ""
echo "============================="
echo "php服务已启动"
echo "============================="
echo -e ""
sleep 1s
systemctl enable php-fpm
ln -s /usr/local/php/bin/php /usr/local/bin/php
ln -s /usr/local/php/bin/pecl /usr/local/bin/pecl
ln -s /usr/local/php/bin/php-config /usr/local/bin/php-config
ln -s /usr/local/php/bin/phpize /usr/local/bin/phpize
INSTALL_INFO=$INSTALL_INFO"php服务通信地址：127.0.0.1:9000\nphp版本：7.2.34\n\n"