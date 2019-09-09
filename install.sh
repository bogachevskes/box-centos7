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

configFile=$domain.conf
hostConfig=/vagrant/conf/$configFile

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
eval "echo \"$(cat /vagrant/templates/v-host.tpl)\"" > $hostConfig

sudo cp $hostConfig /etc/apache2/sites-available
sudo a2ensite $domain.conf
sudo chown $USER:$USER -R $htmlPath
sudo chown $USER:$USER -R $logPath
sudo service apache2 restart

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
# loggind without sudo
sudo mysql -u root
DROP USER 'root'@'localhost';
CREATE USER 'root'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
sudo service mysqld restart
