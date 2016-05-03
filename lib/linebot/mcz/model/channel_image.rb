module Linebot
  module Mcz
    module Model
      class ChannelImage <  ActiveRecord::Base
        belongs_to :channel_item
      end
    end
  end
end
