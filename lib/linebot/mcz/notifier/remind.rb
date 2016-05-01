module Linebot
  module Mcz
    module Notifier
      class Remind
        def initialize
          @now = DateTime.now
        end

        def notify(mid = nil)
          Linebot::Mcz::Database.connect
          to_mid = mid.nil? ? user_mids : mid

          if in_happy_clover?
            Linebot::Mcz.client.send_text(
                to_mid: to_mid,
                text: "まもなく「ももいろクローバーZのSUZUKIハッピー・クローバー！」\nTOKYO FM 16:00-16:55"
            )
          end

          if in_momoclo_club?
            Linebot::Mcz.client.send_text(
                to_mid: to_mid,
                text: "もうすぐ「ももいろクローバーZ ももクロくらぶxoxo」\nニッポン放送 22:00-22:30"
            )
          end
        end

        private

        # TODO: using database

        def in_happy_clover?
          @now.wday == 0 && @now.hour == 15 && @now.min == 50
        end

        def in_momoclo_club?
          @now.wday == 0 && @now.hour == 21 && @now.min == 50
        end

        def user_mids
          Linebot::Mcz::Model::User.all.pluck(:mid)
        end
      end
    end
  end
end
