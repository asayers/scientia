#! /bin/bash

echo "Setting environment variables..."
export RAILS_ENV="production"
echo "Updating to latest version..."
git pull
echo "Migrating database..."
rake db:migrate
echo "Precompiling assets..."
rake assets:precompile
echo "Done!"
