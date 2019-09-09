<VirtualHost *:80>
    ServerName $1
    DocumentRoot $htmlPath
    ErrorLog $logPath/error.log
    CustomLog $logPath/access.log combined
</VirtualHost>