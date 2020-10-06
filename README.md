MariaDB Dockerfile
==================

Based on CentOS7 original mariadb Dockerfile, based on https://github.com/CentOS/CentOS-Dockerfiles/tree/master/mariadb/centos7

# Build
`$ docker build -t mymariadb:centos .`
# Tag and Push
`$ docker tag mymariadb:centos msakhawat/mymariadb:centos`

`$ docker push msakhawat/mymariadb:centos`

# Pull from msakhawat on docker.io
`$ docker pull msakhawat/mymariadb:centos`
# Run
`$ docker run --name=mymariadb -d -p 3306:3306 -v mymariadb-data -e MYSQL_ROOT_PASSWORD=root mymariadb:centos`