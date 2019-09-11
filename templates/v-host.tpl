<VirtualHost *:$port>
    ServerName $1
    DocumentRoot $htmlPath/$3
    ErrorLog $logPath/error.log
    CustomLog $logPath/access.log combined
</VirtualHost>