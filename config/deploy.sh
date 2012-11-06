#! /bin/bash

git pull origin master
echo "Restarting unicorn..."
sudo systemctl restart unicorn_scientia
echo "Restarting sidekiq..."
sudo systemctl restart sidekiq_scientia
