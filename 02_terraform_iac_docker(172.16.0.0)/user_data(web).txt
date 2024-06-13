#! /bin/bash
yum install -y httpd 
wget https://ko.wordpress.org/wordpress-5.8.8-ko_KR.tar.gz
tar xvfz wordpress-5.8.8-ko_KR.tar.gz
cp -r wordpress/* /var/www/html/
cat > /var/www/html/index.html << EOF
<html><body><h1>Ogurim Web Server</h1></body></html>
EOF
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf
amazon-linux-extras enable php7.4
yum install -y php php-cli php-curl php-mysqlnd php-gd php-opcache php-common
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
sed -i 's/username_here/root/g' /var/www/html/wp-config.php
sed -i 's/password_here/12345/g' /var/www/html/wp-config.php
sed -i 's/localhost/ogurim-db.cd4qy6s265xk.ap-northeast-2.rds.amazonaws.com/g' /var/www/html/wp-config.php
systemctl enable --now httpd