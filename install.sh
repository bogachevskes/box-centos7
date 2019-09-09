#!/bin/bash
domain=virtual-example.com
docRoot=/var/www
hostDir=/vagrant
php=php5.6

sudo mkdir		$docRoot
sudo mkdir -p	$hostDir/html
sudo mkdir -p	$hostDir/log
sudo ln -s		$hostDir/html $docRoot/html
sudo ln -s		$hostDir/log $docRoot/log

sudo apt-get update -y

# apache
sudo apt-get install -y apache2

# template
echo "##### Generating site's filesystems #####"
sudo bash $hostDir/scripts/generate_vhost.sh $domain 80

# php
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -y
sudo apt-get install -y php5.6 php-dev php-pear libapache2-mod-php
php -v
# extensions
sudo apt-get install -y $php-intl $php-gmp $php-imap $php-ldap $php-mbstring $php-mysqli $php-imagick $php-memcached $php-soap $php-tidy $php-xmlrpc $php-zip

# mariaDB
sudo apt-get install -y software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository -y "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
sudo apt update -y
sudo apt install -y mariadb-server
