module Linebot
  module Mcz
    module Model
      class Channel <  ActiveRecord::Base
        has_many :channel_items
      end
    end
  end
end
