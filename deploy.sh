#! /bin/bash

echo "> Synching repo"
git pull origin master
echo -n "Recompile assets? "
read ASSETS
if [ $ASSETS == "y" ]; then
  echo "> Precompiling assets..."
  bundle exec rake assets:precompile
fi
echo -n "Migrate database? "
read MIGRATE
if [ $MIGRATE == "y" ]; then
  echo "> Migrating database..."
  bundle exec rake db:migrate
fi
echo "> Restarting sidekiq..."
sudo systemctl restart sidekiq_scientia
echo "> Restarting unicorn..."
sudo systemctl restart unicorn_scientia
