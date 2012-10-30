#! /bin/bash

echo "Linking nginx config..."
sudo ln -s $(pwd)/config/nginx.conf /etc/nginx/sites-enabled/scientia
echo "Installing bundler..."
gem install bundler
echo "Installing dependencied"
bundle install --binstubs
echo "Creating database..."
rake db:create
echo "Migrating database..."
rake db:migrate
echo "Seeding database..."
rake db:seed
echo "Precompiling assets..."
rake assets:precompile
