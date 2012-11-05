#! /bin/bash

git pull origin master
sudo systemctl restart unicorn_scientia
sudo systemctl restart sidekiq_scientia
