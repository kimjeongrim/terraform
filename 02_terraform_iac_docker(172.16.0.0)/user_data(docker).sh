#! /bin/bash
# install docker package and start
yum install -y docker
systemctl enable --now docker

# image pull
docker pull mysql:5.7
docker pull wordpress:5.7

# container run
docker run -itd --name m1 \
-e MYSQL_ROOT_PASSWORD=12345 \
-e MYSQL_DATABASE=wordpress mysql:5.7

sleep 30
MYSQL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' m1)

docker run -itd --name w1 -p 61080:80 \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=12345 \
-e WORDPRESS_DB_HOST=$MYSQL_IP \
-e WORDPRESS_DB_NAME=wordpress wordpress:5.7