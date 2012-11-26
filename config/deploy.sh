#! /bin/bash

echo -n "Recompile assets? "
read ASSETS
echo -n "Migrate database? "
read MIGRATE

echo "> Synching repo"
git pull origin master
if [ $ASSETS == "y" ]; then
  echo "> Precompiling assets..."
  bundle exec rake assets:precompile
fi
if [ $MIGRATE == "y" ]; then
  echo "> Migrating database..."
  bundle exec rake db:migrate
fi
echo "> Restarting sidekiq..."
sudo systemctl restart sidekiq_scientia
echo "> Restarting unicorn..."
sudo systemctl restart unicorn_scientia
