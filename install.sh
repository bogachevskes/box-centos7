#!/bin/bash

domain=virtual-example.com
docRoot=/var/www
hostDir=/vagrant
php=php5.6
publicPath="/web"
vhScript=$hostDir/scripts/generate_vhost.sh

sudo mkdir		$docRoot
sudo mkdir -p	$hostDir/html
sudo mkdir -p	$hostDir/log
sudo ln -s		$hostDir/html $docRoot/html
sudo ln -s		$hostDir/log $docRoot/log

sudo apt-get update -y

# common utils
sudo apt-get install -y dos2unix

# apache
sudo apt-get install -y apache2
sudo cp $hostDir/common/conf/apache2.conf /etc/apache2/
sudo a2enmod rewrite

# template
echo "##### Generating sites filesystems #####"
sudo dos2unix $vhScript
sudo bash $vhScript $domain 80 $publicPath $php

# php
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -y
sudo apt-get install -y $php $php-fpm php-dev php-pear libapache2-mod-php libapache2-mod-fcgid
php -v
# extensions
sudo apt-get install -y $php-intl $php-gmp $php-imap $php-ldap $php-mcrypt $php-mbstring $php-mysqli $php-imagick $php-memcached $php-memcache $php-soap $php-tidy $php-xmlrpc $php-zip

# memcached
sudo apt-get -y install memcached
sudo service memcached start

# mariaDB
sudo apt-get install -y software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository -y "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
sudo apt update -y
sudo apt install -y mariadb-server

# fast-cgi
sudo a2enmod actions alias proxy_fcgi fcgid
sudo service apache2 restart