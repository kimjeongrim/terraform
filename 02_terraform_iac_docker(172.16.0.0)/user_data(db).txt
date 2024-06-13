#! /bin/bash
yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/mysql-community.repo
yum install -y mysql-community-server
systemctl enable --now mysqld
password_match=`awk '/A temporary password is generated for/ {a=$0} END{ print a }' /var/log/mysqld.log | awk '{print $(NF)}'`
echo $password_match
mysql -uroot -p$password_match --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345'; flush privileges; "
password=12345
mysql -uroot -p$password -e "grant all privileges on *.* to 'root'@'%' IDENTIFIED BY '12345';  create database wordpress; flush privileges;"