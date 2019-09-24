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
       SetHandler proxy:fcgi://127.0.0.1:90$php
   </FilesMatch>

</VirtualHost>