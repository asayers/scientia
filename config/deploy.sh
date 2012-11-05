#! /bin/bash

gpull
sudo systemctl restart unicorn_scientia
sudo systemctl restart sidekiq_scientia
