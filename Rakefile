namespace :sidekiq do
  desc 'Run sidekiq worker'
  task :run do
    load_path = File.expand_path('../lib', __FILE__)
    daemon = ENV['daemon_enable'].nil? ? '' : '-d'
    system("RUBYLIB=#{load_path} bundle exec sidekiq -r ./lib/linebot/mcz.rb -c 10 #{daemon}")
  end
end
