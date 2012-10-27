#! /bin/bash

sudo ln -s $(pwd)/config/nginx.conf /etc/nginx/sites-enabled/scientia
gem install bundler
bundle install --binstubs
rake db:create
rake db:migrate
rake db:seed
