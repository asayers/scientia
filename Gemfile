source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Server gems
gem 'pg'
gem 'thin'
#gem 'unicorn'
gem 'sidekiq'

# Sidekiq monitoring
gem 'slim'
gem 'sinatra', :require => nil

# Authentication
gem 'sorcery'

# Make development easier
gem 'haml-rails'
gem 'simple_form'

# For non-resourceful routes
gem 'friendly_id'

# Rendering
gem 'liquid', git: "git://github.com/asayers/liquid.git"
#gem 'pandoc-ruby'       # Will change to Kramdown
gem 'rpeg-multimarkdown'
gem 'rtex'              # Will change to just using rubber (external)
# md -> latex:  redcarpet, Kramdown, Multimarkdown
# latex -> pdf: rtex, rubbr, rails-latex
# md -> pdf:    maruku, pandoc-ruby

# For a nice json api: gem 'rabl'
# For easy ajax: gem 'pjax_rails'

# Gems used only in the development environment
group :development do
#  gem 'foreman'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'hirb'
  gem 'rack-mini-profiler'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
#  gem 'compass-rails'
  gem 'bourbon'
  # Also: 'bootstrap-sass', 'font-awesome-rails', 'grater'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
