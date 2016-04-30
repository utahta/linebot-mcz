module Linebot
  module Mcz
    class Client < Line::Bot::Client
      def initialize
        super do |config|
          config.channel_id = ENV["LINE_CHANNEL_ID"]
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_mid = ENV["LINE_CHANNEL_MID"]
        end
      end
    end
  end
end
