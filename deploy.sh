#! /bin/bash

git pull
rake db:migrate
rake assets:precompile
foreman start &
