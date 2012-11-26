#! /bin/bash

APP_NAME="scientia"

echo "Linking config files..."
sudo ln -s $(pwd)/config/nginx.conf /etc/nginx/sites-enabled/$APP_NAME
sudo cp $(pwd)/config/unicorn.service /usr/lib/systemd/system/unicorn_$APP_NAME.service
sudo cp $(pwd)/config/sidekiq.service /usr/lib/systemd/system/sidekiq_$APP_NAME.service
echo "Enabling services..."
sudo systemctl enable unicorn_scientia
sudo systemctl enable sidekiq_scientia
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
echo "Starting services..."
sudo systemctl start unicorn_scientia
sudo systemctl start sidekiq_scientia
