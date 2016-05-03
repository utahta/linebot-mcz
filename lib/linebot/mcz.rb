require 'logger'
require 'json'
require 'faraday'
require 'sidekiq'
require 'dotenv'
require 'active_record'
require 'line/bot'
require 'linebot/mcz/client'
require 'linebot/mcz/google_custom_api'
require 'linebot/mcz/kwkm'
require 'linebot/mcz/logger'
require 'linebot/mcz/database'
require 'linebot/mcz/model/user'
require 'linebot/mcz/model/channel'
require 'linebot/mcz/model/channel_item'
require 'linebot/mcz/model/channel_image'
require 'linebot/mcz/scheduler/send_image'
require 'linebot/mcz/scheduler/add_user'
require 'linebot/mcz/scheduler/delete_user'
require 'linebot/mcz/scheduler/notification_receiver'
require 'linebot/mcz/notifier/channel_items'
require 'linebot/mcz/notifier/blog'
require 'linebot/mcz/notifier/remind'
require 'linebot/mcz/notifier/ustream'
Dotenv.load

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('RACK_ENV') }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('RACK_ENV') }
end

module Linebot
  module Mcz
    def self.client
      @client ||= Linebot::Mcz::Client.new
    end

    def self.logger
      @logger ||= Linebot::Mcz::Logger.new
    end
  end
end
