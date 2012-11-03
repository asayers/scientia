if ENV["RAILS_ENV"] == "production"
  root = "/home/scientia/scientia"
else
  root = "/home/alex/git/scientia"
end

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.scientia.sock"
worker_processes 5
timeout 30
preload_app true

# Make sure each worker uses its own connection (avoid 'prepared statement "a3" already exists' errors)
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
