set :application, 'jeffs_store'
set :repo_url, 'https://github.com/eng/jeffs-store.git'
set :deploy_to, '/home/deploy/apps/jeffs-store'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
