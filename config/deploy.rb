server "scientia.asayers.org", :web, :app, :db, primary: true

set :application, "scientia"
set :user, "scientia"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache # Prevent cloning the repo on each deploy
#set :use_sudo, false
set :scm, :git
set :repository,  "git@github.com:asayers/scientia.git"
set :branch, "master"

default_run_options[:pty] = true # Allows programs like git to prompt for password
ssh_options[:forward_agent] = true # Use local ssh key for accessing repo

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/rc.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/rc.d/unicorn_#{application}"
  end
  after "deploy:setup", "deploy:setup_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
