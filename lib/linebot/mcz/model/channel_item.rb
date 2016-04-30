module Linebot
  module Mcz
    module Model
      class ChannelItem <  ActiveRecord::Base
        belongs_to :channel
      end
    end
  end
end
