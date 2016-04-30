module Linebot
  module Mcz
    module Notifier
      class Blog
        def initialize
          @logger = Linebot::Mcz::Logger.new
        end

        def notify(mid = nil)
          Linebot::Mcz::Database.connect

          client = Linebot::Mcz::Client.new
          to_mid = mid.nil? ? user_mids : mid

          lined_at = DateTime.now
          blog_items.each do |item|
            item.lined_at = lined_at
            item.save!
            client.send_text(to_mid: to_mid, text: "#{item.title}\n#{item.url}")
          end
        end

        private

        def blog_items
          codes = ['tamai-sd', 'momota-sd', 'ariyasu-sd', 'sasaki-sd', 'takagi-sd']
          Linebot::Mcz::Model::ChannelItem.joins(:channel).where('channels.code in (?)', codes).where(lined_at: nil)
        end

        def user_mids
          Linebot::Mcz::Model::User.all.pluck(:mid)
        end
      end
    end
  end
end
