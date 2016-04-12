module Linebot
  module Mcz
    module Scheduler
      class PostImage
        include Sidekiq::Worker

        def perform(to, search_word)
          message_api = Linebot::Mcz::MessageApi.new

          if search_word
            google_custom_api = Linebot::Mcz::GoogleCustomApi.new
            original_content_url, preview_image_url = google_custom_api.search_image(search_word)
            message_api.post_image(to, original_content_url, preview_image_url)
          else
            kwkm = Linebot::Mcz::Kwkm.new
            original_content_url, preview_image_url = kwkm.image
            message_api.post_image(to, original_content_url, preview_image_url)
          end
        end
      end
    end
  end
end
