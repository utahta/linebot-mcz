require 'logger'
require 'json'
require 'faraday'
require 'sidekiq'
require 'dotenv'
require 'linebot/mcz/message_api'
require 'linebot/mcz/google_custom_api'
require 'linebot/mcz/kwkm'
require 'linebot/mcz/logger'
require 'linebot/mcz/scheduler/post_image'
Dotenv.load

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('LINEBOT_MCZ_ENV') }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('LINEBOT_MCZ_ENV') }
end
