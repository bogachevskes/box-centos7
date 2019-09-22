<VirtualHost *:$2>
    ServerName $1
    DocumentRoot $hostHtmlPublicPath
    ErrorLog $logPath/error.log
    CustomLog $logPath/access.log combined

    <Directory $hostHtmlPublicPath>
        AllowOverride all
        Require all granted
    </Directory>

    <FilesMatch \.php$>
        SetHandler proxy:unix:/var/run/php-fpm/$php-fpm.sock|fcgi://localhost
    </FilesMatch>

</VirtualHost>