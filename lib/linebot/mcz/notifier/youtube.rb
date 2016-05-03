module Linebot
  module Mcz
    module Notifier
      class Youtube
        def notify(mid = nil)
          Linebot::Mcz::Database.connect

          to_mid = mid.nil? ? Linebot::Mcz::Model::User.to_mid : mid

          lined_at = DateTime.now
          channel_items.each do |item|
            item.lined_at = lined_at
            item.save!
            Linebot::Mcz.client.send_text(to_mid: to_mid, text: "#{item.channel.title}\n#{item.title}\n#{item.url}")
          end
        end

        private

        def channel_items
          Linebot::Mcz::Model::ChannelItem.joins(:channel).where('channels.code = ?', 'new-type-yt').where(lined_at: nil)
        end
      end
    end
  end
end
