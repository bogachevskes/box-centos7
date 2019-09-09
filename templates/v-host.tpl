<VirtualHost *:80>
    ServerName $domain
    DocumentRoot $htmlPath
    ErrorLog $logPath/error.log
    CustomLog $logPath/access.log combined
</VirtualHost>