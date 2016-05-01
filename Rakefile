LIB_PATH = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(LIB_PATH) unless $LOAD_PATH.include?(LIB_PATH)
require 'bundler/setup'
require 'linebot/mcz'

namespace :sidekiq do
  desc 'Run sidekiq worker'
  task :run do
    daemon = ENV['daemon'].nil? ? '' : '-d'
    logfile = ENV['log'].nil? ? '' : "-L #{ENV['log']}"
    system("RUBYLIB=#{$LOAD_PATH.join(':')} bundle exec sidekiq -r ./lib/linebot/mcz.rb -c 10 #{daemon} #{logfile}")
  end
end

namespace :notifier do
  desc 'Notify mcz informations'
  task :all do
    Linebot::Mcz::Notifier::ChannelItems.new.notify
  end
end
