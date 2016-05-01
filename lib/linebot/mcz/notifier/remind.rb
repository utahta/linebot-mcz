module Linebot
  module Mcz
    module Notifier
      class Remind
        def notify(mid = nil)
          # Linebot::Mcz::Database.connect
          #
          # to_mid = mid.nil? ? user_mids : mid
        end

        private

        def user_mids
          Linebot::Mcz::Model::User.all.pluck(:mid)
        end
      end
    end
  end
end
