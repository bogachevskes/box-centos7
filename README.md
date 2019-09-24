# CentOS 7 Box
> Host machine - Windows

### Сборка
* CentOS 7
* php7.1
* php5.6
* php5.4
* Fast-cgi
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
Добавление виртуального хоста | домен | порт | публичная папка | php версия (71|56) - по умолчанию 71
```sh
$ vagrant ssh
$ sudo generate-vhost host.example.com 80 "public"
```