#!/bin/bash
docRoot=/var/www

htmlPart=html/$1
logPart=log/$1

hostDir=/vagrant
hostHtml=$hostDir/$htmlPart
hostLog=$hostDir/$logPart

htmlPath=$docRoot/$htmlPart
logPath=$docRoot/$logPart
sitesComon=$hostDir/sites_common

configFile=$1.conf

echo "Started files generation ######################################################"

mkdir -p $hostHtml
mkdir -p $hostLog

cp $sitesComon/index.php	$hostHtml
cp $sitesComon/access.log	$hostLog
cp $sitesComon/error.log	$hostLog

eval "echo \"$(cat /vagrant/templates/v-host.tpl)\"" > /etc/apache2/sites-available/$configFile

a2ensite $configFile
chown $USER:$USER -R $htmlPath
chown $USER:$USER -R $logPath
service apache2 restart