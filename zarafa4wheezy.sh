#!/bin/bash

apt-get update
apt-get -y upgrade
apt-get -y install postfix mysql-server apache2 php5

mysql_secure_installation

echo "deb http://repo.yaffas.org/releases/latest/wheezy ./" >> /etc/apt/sources.list.d/zarafa-yaffas.list
wget -O - http://repo.yaffas.org/repo.deb.key | apt-key add -

apt-get -y install zarafa zarafa-utils zarafa-webapp

cd /tmp
wget http://download.z-push.org/final/2.1/z-push-2.1.3-1892.tar.gz
tar -xf z-push-2.1.3-1892.tar.gz

mkdir -p /usr/share/z-push
mkdir -p /var/lib/z-push
mkdir -p /var/log/z-push

cp -R z-push-2.1.3-1892/* /usr/share/z-push

chown -R www-data:zarafa /var/lib/z-push
chown -R www-data:zarafa /var/log/z-push
chown -R www-data:zarafa /usr/share/z-push

ln -s /usr/share/z-push/z-push-admin.php /usr/sbin/z-push-admin
ln -s /usr/share/z-push/z-push-top.php /usr/sbin/z-push-top

mysql -uroot -p -e "grant all privileges on zarafa.* to 'zarafa'@'localhost' identified by 'password';"



