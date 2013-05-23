set :application, "jeffs-store"
set :repository,  "https://github.com/eng/jeffs-store.git"
set :scm, :git
set :deploy_via, :remote_cache

role :web, "192.168.33.10"
role :app, "192.168.33.10"
role :db,  "192.168.33.10"

set :user, "deploy"
set :deploy_to, "/home/deploy/apps/jeffs-store"

set :use_sudo, false
set :normalize_asset_timestamps, false

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:setup", "deploy:dbyml_upload"
after "deploy:update_code","deploy:dbyml_symlink"

namespace :deploy do

  task :dbyml_upload do
    run "mkdir -p #{shared_path}/config"
    data = File.open('./apps/jeffs-store/shared/config/database.yml', 'rb').read
    put data, "#{shared_path}/config/database.yml"
  end

  task :dbyml_symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

end
