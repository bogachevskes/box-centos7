#!/bin/bash

domain=virtual-example.com
docRoot=/var/www

htmlPart=html/$domain
logPart=log/$domain

hostDir=/vagrant
hostHtml=$hostDir/$htmlPart
hostLog=$hostDir/$logPart

htmlPath=$docRoot/$htmlPart
logPath=$docRoot/$logPart
sitesComon=$hostDir/sites_common

php=php5.6

sudo mkdir -p $hostHtml
sudo mkdir -p $hostLog

sudo cp $sitesComon/index.php	$hostHtml
sudo cp $sitesComon/access.log	$hostLog
sudo cp $sitesComon/error.log	$hostLog

sudo mkdir $docRoot
sudo ln -s $hostDir/html $docRoot/html
sudo ln -s $hostDir/log $docRoot/log

sudo apt-get update -y

# apache
sudo apt-get install -y apache2

# template
eval "echo \"$(cat /vagrant/templates/v-host.tpl)\"" > /vagrant/conf/$domain.conf

sudo cp /vagrant/conf/httpd.conf /etc/httpd/conf/httpd.conf
sudo mkdir /etc/httpd/sites-available

sudo cp /vagrant/conf/$domain.conf /etc/httpd/sites-available
sudo mkdir /etc/httpd/sites-enabled
sudo ln -s /etc/httpd/sites-available/$domain.conf /etc/httpd/sites-enabled/$domain.conf
sudo chown apache:apache -R $htmlPath
sudo chown apache:apache -R $logPath
sudo setenforce 0
sudo service apache2 restart

# php
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -y
sudo apt-get install -y php5.6 php-dev php-pear libapache2-mod-php
php -v
# extensions
sudo apt-get install -y $php-intl
sudo apt-get install -y $php-gmp
sudo apt-get install -y $php-imap
sudo apt-get install -y $php-ldap
sudo apt-get install -y $php-mbstring
sudo apt-get install -y $php-mysqli
sudo apt-get install -y $php-pdo_odbc
sudo apt-get install -y $php-imagick
sudo apt-get install -y $php-pdo_pgsql
sudo apt-get install -y $php-memcached
sudo apt-get install -y $php-soap
sudo apt-get install -y $php-tidy
sudo apt-get install -y $php-xmlrpc
sudo apt-get install -y $php-zip
# imagick
sudo apt-get install -y imagemagick

# mariaDB
sudo apt-get install -y software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository -y "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
sudo apt update -y
sudo apt install -y mariadb-server