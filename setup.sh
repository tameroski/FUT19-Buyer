#!/bin/bash

DIR="/var/www/fut19"

#Install Required Packages
composer install --no-dev

#chmod folder
sudo chmod -R 777 $DIR/storage
sudo chmod 777 -R $DIR/bootstrap/cache

#make cookies folder
mkdir $DIR/storage/app/fut_cookies

#create env file
#cp $DIR/.env.example $DIR/.env

#generate key
php artisan key:generate

#create database tables
php artisan migrate

#install default settings
php artisan db:seed

#create cron
line="* * * * * php $DIR/artisan schedule:run >> /dev/null 2>&1"
(crontab -u root -l; echo "$line" ) | crontab -u root -
