#! /bin/bash

ln -s $(pwd)/config/nginx.conf /etc/nginx/sites-enabled/scientia
echo "Starting psql. Remember: create user scientia with password 'foobar'; create database scientia with owner scientia;"
sudo -u postgres psql
rake db:migrate
rake db:seed
