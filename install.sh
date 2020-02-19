#!/bin/bash

domain=virtual-example.com
docRoot=/var/www
binPath=/bin
hostDir=/vagrant
httpdPath=/etc/httpd
publicPath="public"
commonPath=$hostDir/common
scriptPath=$hostDir/scripts
vhGenerator=generate-vhost
vhRemover=remove-vhost
serverRestarter=server-restart
phpChanger=set-php
installerRepos=/etc/yum.repos.d/

sudo timedatectl set-timezone Europe/Moscow

sudo yum update -y

echo "##### Generating common filesystems #####"
sudo mkdir $docRoot
sudo mkdir -p $hostDir/html
sudo mkdir -p $hostDir/log
sudo ln -s $hostDir/html $docRoot/html
sudo ln -s $hostDir/log $docRoot/log
sudo cp -rf $scriptPath/* $binPath
sudo cp -rf $commonPath/repo/* $installerRepos

# common utils
sudo yum install -y epel-release htop nano dos2unix \
    net-tools gcc ImageMagick ImageMagick-devel \
    wget unzip

# scripts init
sudo dos2unix $binPath/$vhGenerator
sudo dos2unix $binPath/$vhRemover
sudo dos2unix $binPath/$serverRestarter
sudo dos2unix $binPath/$phpChanger
sudo chmod u+x $binPath/$vhGenerator
sudo chmod u+x $binPath/$serverRestarter
sudo chmod u+x $binPath/$serverRestarter
sudo chmod u+x $binPath/$phpChanger

# apache
sudo yum update -y
sudo yum install -y httpd mod_fcgid
sudo cp -rf $commonPath/conf/httpd.conf $httpdPath/conf/httpd.conf
sudo mkdir $httpdPath/sites-available
sudo mkdir $httpdPath/sites-enabled

# template
echo "##### Generating sites filesystems #####"
sudo $vhGenerator $domain 80 $publicPath false

# php
sudo rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y update
sudo yum -y install php php56 php71

# extensions 5.6
sudo yum install -y php56-php-intl php56-php-opcache php56-php-fpm \
    php56-php-gmp php56-php-imap php56-php-ldap php56-php-memcache \
    php56-php-xmlwriter php56-php-mcrypt php56-php-mbstring \
    php56-php-mysqli php56-php-imagick php56-php-memcached \
    php56-php-soap php56-php-tidy php56-php-xmlrpc php56-php-zip php56-php-gd

# extensions 7.1
sudo yum install -y php71-php-opcache php71-php-mcrypt \
    php71-php-fpm php71-php-intl php71-php-gmp php71-php-imap \
    php71-php-ldap php71-php-mbstring php71-php-mysqli \
    php71-php-pdo_odbc php71-php-pdo_pgsql php71-php-redis \
    php71-php-redis php71-php-memcached php71-php-soap php71-php-tidy \
    php71-php-xmlrpc php71-php-zip php71-php-devel php71-php-pear \
    php71-php-imagick php71-php-gd

# fast-cgi
remiDir=/etc/opt/remi
fpmConf=php-fpm.d/www.conf
sudo systemctl stop php56-php-fpm
sudo systemctl stop php71-php-fpm
sudo sed -i 's/:9000/:9056/' $remiDir/php56/$fpmConf
sudo sed -i 's/:9000/:9071/' $remiDir/php71/$fpmConf

# Databases
sudo yum install -y memcached redis MariaDB-server

# autoload
sudo systemctl enable httpd
sudo systemctl enable php71-php-fpm
sudo systemctl enable php56-php-fpm
sudo systemctl enable mariadb
sudo systemctl enable redis
sudo systemctl enable memcached

# php terminal alternatives
phpPath=/usr/local/bin/php
sudo update-alternatives --install $phpPath php /opt/remi/php56/root/usr/bin/php 10
sudo update-alternatives --install $phpPath php /opt/remi/php71/root/usr/bin/php 20
sudo update-alternatives --install $phpPath php /usr/bin/php 30

sudo set-php 7
php -v

# composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer

sudo $serverRestarter

echo "##### Server installed #####"
