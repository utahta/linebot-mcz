module Linebot
  module Mcz
    module Model
      class User <  ActiveRecord::Base
        scope :to_mid, -> { all.pluck(:mid) }
      end
    end
  end
end
