#! /bin/bash

# set RDS IP
# RDS_ENDPOINT=RDS_ENDPOINT=$(terraform output -raw ogurim_db_ep)
# MYSQL_IP=$RDS_ENDPOINT

# mysql-client
yum install -y mysql-community-client

# install docker package and start
yum install -y docker
systemctl enable --now docker

# image pull
docker pull wordpress:5.7

# container run
docker run -itd --net host --name w1 -p 60080:80 \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=It12345! \
-e WORDPRESS_DB_HOST=ogurim-db.c38o4i2sgnkf.ap-northeast-1.rds.amazonaws.com \
-e WORDPRESS_DB_NAME=wordpress wordpress:5.7

# install firewalld
yum install -y firewalld
systemctl enable --now firewalld

# open firewall ports
# firewall-cmd --add-port=60080/tcp --permanent
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload