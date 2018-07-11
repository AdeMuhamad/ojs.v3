FROM centos:7

RUN yum update -y
RUN yum upgrade -y 
RUN yum install vim net-tools telnet -y

RUN mkdir -p /code
ADD ojs-3.1.1-2 /code
RUN mkdir /files
 

#NGINX
ADD nginx-stable.repo /etc/yum.repos.d/
RUN yum install -y nginx
ADD nginx.conf /etc/nginx/
ADD nginx.service /usr/lib/systemd/system/
ADD ojs.conf /etc/nginx/conf.d/default.conf 

#PHP
RUN yum install epel-release -y
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install yum-utils -y
RUN yum-config-manager --enable remi-php72
RUN yum install -y php72 php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache
ADD www.conf /etc/opt/remi/php72/php-fpm.d/

RUN chown -R apache:apache /files
RUN chown -R apache:apache /code

EXPOSE 80
