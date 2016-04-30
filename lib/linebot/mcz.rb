require 'logger'
require 'json'
require 'faraday'
require 'sidekiq'
require 'dotenv'
require 'line/bot'
require 'linebot/mcz/client'
require 'linebot/mcz/google_custom_api'
require 'linebot/mcz/kwkm'
require 'linebot/mcz/logger'
require 'linebot/mcz/scheduler/send_image'
Dotenv.load

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('RACK_ENV') }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), namespace: ENV.fetch('RACK_ENV') }
end
