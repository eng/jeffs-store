set :application, "jeffs-store"
set :repository,  "https://github.com/eng/jeffs-store.git"
set :scm, :git
set :deploy_via, :remote_cache

role :web, "192.168.33.10"
role :app, "192.168.33.10"
role :db,  "192.168.33.10"

set :user, "deploy"
set :deploy_to, "/home/deployer/apps/jeffs-store"

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
    data = File.open('./apps/shared/config/database.yml', 'rb').read
    puts data, "#{shared_dir}/config/database.yml"
  end

  task :dbyml_symlink do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  end

end
