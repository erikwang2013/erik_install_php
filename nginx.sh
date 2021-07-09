#!/bin/bash
WEB_PORT=8189

firewall-cmd --zone=public --add-port=$WEB_PORT/tcp --permanent
firewall-cmd --reload
echo -e ""
echo "============================="
echo "复制nginx服务文件"
echo "============================="
echo -e ""
sleep 1s
chmod -R 777 $ADDRESS_FILE
\cp -rf $ADDRESS_FILE/etc/init.d/nginx /etc/init.d/
echo -e ""
echo "============================="
echo "服务程序文件已复制成功，开始复制扩展及配置文件"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/etc/systemd/system/nginx.service /etc/systemd/system/
echo -e ""
echo "============================="
echo "扩展及配置文件已复制成功，开始复制主程序"
echo "============================="
echo -e ""
\cp -rf $ADDRESS_FILE/usr/local/nginx /usr/local/
echo -e ""
echo "============================="
echo "主程序已复制成功,开始创建目录"
echo "============================="
echo -e ""
sleep 1s
mkdir -p /var/tmp/nginx/client /var/run/tmp/nginx/client
echo -e ""
echo "============================="
echo "目录创建完成"
echo "============================="
sleep 1s
echo "============================="
echo "给目录和程序添加权限"
echo "============================="
echo -e ""
sleep 1s
chmod a+x /etc/init.d/nginx /etc/systemd/system/nginx.service
chmod -R 777 /var/tmp/nginx /usr/local/nginx/html
echo -e ""
echo "============================="
echo "权限添加完成";
echo "============================="
echo -e ""
sleep 1s
systemctl daemon-reload
echo -e ""
echo "============================="
echo "启动nginx服务"
echo "============================="
echo -e ""
sleep 1s
systemctl enable nginx
systemctl start nginx
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
echo -e ""
echo "============================="
echo "nginx服务已启动"
echo "============================="
INSTALL_INFO=$INSTALL_INFO"web服务端口：$WEB_PORT\nnginx版本：1.18.0\n项目代码地址：/usr/local/nginx/html\n\n"
