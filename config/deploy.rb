# -*- encoding : utf-8 -*-
#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

require "bundler/capistrano"
#load "deploy/assets"

set :application,     "riderstate.es"
set :scm,             :git
set :repository,      "git@github.com:pedroherub/riderstate-prelaunch-signup.git" #"."
set :branch,          "origin/master"
set :deploy_via,      :copy
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :rails_env,       "production"
set :deploy_to,       "/usr/share/nginx/www/#{application}"
set :normalize_asset_timestamps, false

set :user,            "ubuntu"
set :group,           ""
set :use_sudo,         true

#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :location, "54.247.175.28"

role :web,    location
role :app,    location
role :db,     location, :primary => true

# specify unicorn location, config and pid file
set :unicorn_binary, "/home/ubuntu/.rvm/gems/ruby-1.9.3-p194/bin/unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "/tmp/unicorn.riderstate.pid"


set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_environment["RAILS_ENV"] = 'production'

# Use our ruby-1.9.3-p194@riderstate gemset
default_environment["PATH"]         = "/home/ubuntu/.rvm/gems/ruby-1.9.3-p194/bin:/home/ubuntu/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/ubuntu/.rvm/rubies/ruby-1.9.3-p194/bin:/home/ubuntu/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
default_environment["GEM_HOME"]     = "/home/ubuntu/.rvm/gems/ruby-1.9.3-p194"
default_environment["GEM_PATH"]     = "/home/ubuntu/.rvm/gems/ruby-1.9.3-p194:/home/ubuntu/.rvm/gems/ruby-1.9.3-p194@global"
default_environment["RUBY_VERSION"] = "ruby-1.9.3-p194"

default_run_options[:shell] = 'bash'

namespace :deploy do

  desc "Deploy the precompiled assets"
  task :deploy_assets, :except => { :no_release => true } do
       run_locally("rake assets:clean && rake assets:precompile")
       top.upload "public/assets", "#{release_path}/public/assets", :via => :scp, :recursive => true
  end

  desc "Deploy your application"
  task :default do
    update
    deploy_assets
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake paperclip:refresh:missing_styles"
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system &&
      ln -s #{shared_path}/tmp/pids #{latest_release}/tmp/pids &&
      ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /tmp/unicorn.riderstate.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat /tmp/unicorn.riderstate.pid`"
  end  

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end
