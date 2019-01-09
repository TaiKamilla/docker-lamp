FROM ubuntu:latest
MAINTAINER Tai Kamilla <TaiKamilla@gmail.com>

LABEL Description="Cutting-edge LAMP stack, based on Ubuntu 16.04 LTS. Includes .htaccess support and popular PHP7 features, including composer and mail() function." \
	License="Apache License 2.0" \
	# Usage="docker run -d -p 80:80 -p 3306:3306 -v /home/yafar/Documents/lamp/docker-lamp/web:/var/www/html -v /home/yafar/Documents/lamp/docker-lamp/mysql:/var/lib/mysql fauria/lamp" \
	Usage="docker build -t <image_name> ." \
	Usage="docker run -dit -p 8080:80 -p 3306:3306 -d -v web:/var/www/web -v mysql:/var/lib/mysql --name <container_name> <image_name>" \
    Usage="docker exec -it <container_name> bash" \
    Usage="http://<docker-host-ip-address>:8080" \





    # Usage="docker build -t lamp_img . && docker run -d -p 8080:80 -p 3306:3306 -d -v web:/var/www/web -v mysql:/var/lib/mysql --name lamp_container lamp_img && docker exec -it lamp_container bash" \



	Version="1.0"


ENV DEBIAN_FRONTEND noninteractive


# Update system

RUN apt-get update
RUN apt-get upgrade -y

# Install basics

RUN apt-get install -y zip unzip
RUN apt-get install -y \
	php7.0 \
	php7.0-*

RUN apt-get install apache2 -y
# RUN apt-get install mariadb-common mariadb-server mariadb-client -y
RUN apt-get install mysql-server -y
RUN apt-get install postfix -y
RUN apt-get install git nodejs npm composer nano tree vim curl ftp ssh emacs zsh -y
RUN npm install -g webpack yarn grunt-cli gulp


EXPOSE 80
EXPOSE 8080
EXPOSE 443
EXPOSE 3306

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND