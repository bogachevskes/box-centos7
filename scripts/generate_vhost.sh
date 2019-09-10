#!/bin/bash
docRoot=/var/www

htmlPart=html/$1
logPart=log/$1
port=$2

hostDir=/vagrant
hostHtml=$hostDir/$htmlPart
hostLog=$hostDir/$logPart

htmlPath=$docRoot/$htmlPart
logPath=$docRoot/$logPart

configFile=$1.conf

mkdir -p $hostHtml
mkdir -p $hostLog

echo '<?php phpinfo(); ?>' > $hostHtml/index.php
echo '' > $hostLog/access.log
echo '' > $hostLog/error.log

eval "echo \"$(cat /vagrant/templates/v-host.tpl)\"" > /etc/apache2/sites-available/$configFile

a2ensite $configFile
chown $USER:$USER -R $htmlPath
chown $USER:$USER -R $logPath
service apache2 restart