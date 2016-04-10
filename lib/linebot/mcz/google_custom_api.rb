module Linebot
  module Mcz
    class GoogleCustomApi
      def initialize
        @conn = Faraday::Connection.new(url: 'https://www.googleapis.com/customsearch/v1') do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger, Linebot::Mcz::Logger.new
          faraday.adapter  Faraday.default_adapter
        end
      end

      def search_image(word)
        response = @conn.get do |req|
          req.params['cx'] = ENV.fetch('GOOGLE_CUSTOM_API_ID')
          req.params['key'] = ENV.fetch('GOOGLE_CUSTOM_API_KEY')
          req.params['q'] = word
          req.params['searchType'] = 'image'
          req.params['num'] = 10
          req.params['start'] = rand(20)
        end

        content = JSON.parse(response.body)
        10.times do
          item = content['items'].sample
          if item['mime'] == 'image/jpeg'
            return [item['link'], item['image']['thumbnailLink']]
          end
        end
        ['', '']
      end
    end
  end
end
