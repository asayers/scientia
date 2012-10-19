root = "/home/server/scientia"
working_directory root
pid "#{root}/tmp/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.scientia.sock"
worker_processes 5
timeout 30
preload_app true
