#! /bin/bash

# set RDS IP
# RDS_ENDPOINT=RDS_ENDPOINT=$(terraform output -raw ogurim_db_ep)
# MYSQL_IP=$RDS_ENDPOINT

# mysql-client
yum install -y mysql-community-client

# install wordpress
yum install -y httpd 
wget https://ko.wordpress.org/wordpress-5.8.8-ko_KR.tar.gz
tar xvfz wordpress-5.8.8-ko_KR.tar.gz
cp -r wordpress/* /var/www/html/
cat > /var/www/html/index.html << EOF
<html>
<body>
        <h1>Ogurim Web Site(tokyo)</h1>
</body>
</html>
EOF
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf

# install php
amazon-linux-extras enable php7.4
yum install -y php php-cli php-curl php-mysqlnd php-gd php-opcache php-common

# modify setting file
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
sudo sed -i 's/username_here/root/g' /var/www/html/wp-config.php
sudo sed -i 's/password_here/It12345!/g' /var/www/html/wp-config.php
sudo sed -i 's/localhost/ogurim-db.c38o4i2sgnkf.ap-northeast-1.rds.amazonaws.com/g' /var/www/html/wp-config.php
#sudo sed -i 's/localhost/$MYSQL_IP/g' /var/www/html/wp-config.php

# restart apache
systemctl enable --now httpd

# install firewalld
# yum install -y firewalld
# systemctl enable --now firewalld

# open firewall ports
# firewall-cmd --add-port=80/tcp --permanent
# firewall-cmd --reload