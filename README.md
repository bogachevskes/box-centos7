# Ubuntu18.04 Box
> Host machine - Windows

### Сборка
* Ubuntu18.04
* php5.6
* memcache
* MariaDB10.4

### Установка
Для работы необходим Vagrant ^2.5.5 и VirtualBox ^6.0.12  
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
$ exit
$ sudo service mysqld restart
```
Добавление виртуального хоста
```sh
$ vagrant ssh
$ sudo bash /vagrant/scripts/generate_vhost.sh host.example.com
```
