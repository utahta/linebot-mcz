module Linebot
  module Mcz
    module Notifier
      class Blog
        def notify(mid = nil)
          Linebot::Mcz::Database.connect

          to_mid = mid.nil? ? Linebot::Mcz::Model::User.to_mid : mid

          lined_at = DateTime.now
          channel_items.each do |item|
            item.lined_at = lined_at
            item.save!

            message = Linebot::Mcz.client.multiple_message
            message.add_text(text: message_text(item))
            item.channel_images.each do |image|
              message.add_image(image_url: image.url, preview_url: image.url)
            end
            message.send(to_mid: to_mid)
          end
        end

        private

        def channel_items
          codes = %w(tamai-sd momota-sd ariyasu-sd sasaki-sd takagi-sd)
          Linebot::Mcz::Model::ChannelItem.joins(:channel).where('channels.code in (?)', codes).where(lined_at: nil)
        end

        def message_text(item)
          "#{item.channel.title}\n#{item.title}\n#{item.url}"
        end
      end
    end
  end
end
