module Linebot
  module Mcz
    module Model
      class ChannelItem <  ActiveRecord::Base
        belongs_to :channel
        has_many :channel_images
      end
    end
  end
end
