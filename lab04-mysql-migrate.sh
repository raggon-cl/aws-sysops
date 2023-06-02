#/bin/bash

#Disable SELINUX
sudo setenforce 0

#Habilitar el acceso en al SG asociado al servidor Wordpress

#Connect to the RDS instance
#mysql --host [RDS_INSTANCE_DNS] -uwpadmin -pPa55w0rd
mysql -h l03t01-wp-db.cl1tgdhxatct.us-east-1.rds.amazonaws.com -uwpadmin -pPa55w0rd

#Create WordPress user.
CREATE USER 'wordpress'@'%' IDENTIFIED BY 'Pa55w0rd';

#Grant privileges
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';

#Flush privileges
FLUSH PRIVILEGES;

#Create Wordpress DB
CREATE DATABASE wordpress;
exit

#Take an export of the current database using MySQL dump.
mysqldump -uwordpress -pPa55w0rd wordpress > wp-export.sql

#Import the MySQL dump into the RDS instance.
mysql --host l03t01-wp-db.cl1tgdhxatct.us-east-1.rds.amazonaws.com -uwpadmin -pPa55w0rd wordpress < wp-export.sql

#Edit wp-config.php file to point to RDS instance instead of localhost.
sudo sed -i 's@localhost@l03t01-wp-db.cl1tgdhxatct.us-east-1.rds.amazonaws.com@' /var/www/html/wp-config.php

#Test Wordpress access

#Create an AMI with the changes
#Image name: lab05-wp-rds-ami
#Image description: WordPress with RDS AMI
#No reboot: Enable (checked)
#Tags: Environment = Training

