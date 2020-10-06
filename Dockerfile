FROM centos:centos7

LABEL MAINTAINER="The CentOS Project <cloud-ops@centos.org>"
LABEL Vendor="CentOS"
LABEL License=GPLv2
LABEL Version=5.5.41

# yum with "--setopt=tsflags=nodocs" to not to install documentation of package

# install epel(Extra Packages for Enterprise Linux), it a opensource package repository
RUN yum -y install --setopt=tsflags=nodocs epel-release && \ 
# mariadb-server    
# bind-utils: utility for querying DNS
# pwgen: password generator
# psmisc: utilities for managing processes on your system(pstree, killall and fuser)
#hostname: provide commands to display the system's DNS name and display or set its hostname

    yum -y install --setopt=tsflags=nodocs mariadb-server bind-utils pwgen psmisc hostname && \ 
# remove vim-minimal package
    yum -y erase vim-minimal && \
# update yum and clean all the cached files
    yum -y update && yum clean all


# Fix permissions to allow for running on openshift
COPY fix-permissions.sh ./
RUN ./fix-permissions.sh /var/lib/mysql/   && \
    ./fix-permissions.sh /var/log/mariadb/ && \
    ./fix-permissions.sh /var/run/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

# Place VOLUME statement below all changes to /var/lib/mysql
VOLUME /var/lib/mysql

# By default will run as random user on openshift and the mysql user (27)
# everywhere else
USER 27

EXPOSE 3306
CMD ["mysqld_safe"]

# Build
## docker build -t mymariadb:centos .
# Push
## docker tag mymariadb:centos msakhawat/mymariadb:centos 
## docker push msakhawat/mymariadb:centos
# Pull
## docker pull msakhawat/mymariadb:centos
# Run
## docker run --name=mymariadb -d -p 3306:3306 -v mymariadb-data -e MYSQL_ROOT_PASSWORD=root mymariadb:centos