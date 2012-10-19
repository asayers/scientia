if ENV["RAILS_ENV"] == "production"
  root = "/home/server/scientia"
else
  root = "/home/alex/git/scientia"
end

working_directory root
pid "#{root}/tmp/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.scientia.sock"
worker_processes 5
timeout 30
