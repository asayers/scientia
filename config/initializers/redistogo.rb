# Redis database for Sidekiq in the development environment
unless ENV["RAILS_ENV"] == "production"
  ENV["REDISTOGO_URL"] = 'redis://asayers:7987993ee766f9fc3ff397f2e450dda5@clingfish.redistogo.com:9641/'
end
