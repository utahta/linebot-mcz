module Linebot
  module Mcz
    module Model
      class Channel <  ActiveRecord::Base
        has_many :channel_item
      end
    end
  end
end
