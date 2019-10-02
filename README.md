# Box CentOS 7
> Host - Windows

### Сборка
* CentOS 7
* php7.1
* php5.6
* php5.4
* Fast-cgi
* Composer
* Redis
* Memcached
* MariaDB10.4

### Установка
Для работы необходим Vagrant ^2.2.5 и VirtualBox ^6.0.12  
Так же, для корректной работы требуется установить vagrant-vbguest
```sh
$ vagrant plugin install vagrant-vbguest
```
### Опционально
Открытие доступа к БД из host
```sh
$ sudo mysql -u root
mysql> DROP USER 'root'@'localhost'; CREATE USER 'root'@'%' IDENTIFIED BY '';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
mysql> exit
$ sudo service mysqld restart
```
Добавление виртуального хоста | домен | порт | публичная папка | php версия ( 56 | 71 ) - по умолчанию 71
```sh
$ sudo generate-vhost host.example.com 80 "public" 71
```
Удаление виртуального хоста | домен
```sh
$ sudo remove-vhost host.example.com
```
Перезагрузка всех сервисов
```sh
$ sudo server-restart
```
Динамическая смена версии php в терминале | php версия ( 5 | 7 ) - по умолчанию 7
```sh
$ sudo set-php 7
```
