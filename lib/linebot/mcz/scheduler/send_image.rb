module Linebot
  module Mcz
    module Scheduler
      class SendImage
        include Sidekiq::Worker

        def perform(to, search_word)
          client = Linebot::Mcz::Client.new

          if search_word
            google_custom_api = Linebot::Mcz::GoogleCustomApi.new
            image_url, preview_url = google_custom_api.search_image(search_word)
            client.send_image(to_mid: to, image_url: image_url, preview_url: preview_url)
          else
            kwkm = Linebot::Mcz::Kwkm.new
            image_url, preview_url = kwkm.image
            client.send_image(to_mid: to, image_url: image_url, preview_url: preview_url)
          end
        end
      end
    end
  end
end
