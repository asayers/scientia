#! /bin/bash

ln -s $(pwd)/config/nginx.conf /etc/nginx/sites-enabled/scientia
sudo -u postgres createuser -s server
rake db:create
rake db:migrate
rake db:seed
