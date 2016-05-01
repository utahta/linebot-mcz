module Linebot
  module Mcz
    module Notifier
      class Ustream
        def notify(mid = nil)
          Linebot::Mcz::Database.connect
          to_mid = mid.nil? ? user_mids : mid

          load_ustream_status
          if on_air? && @status == 'offline'
            Linebot::Mcz.client.send_text(
                to_mid: to_mid,
                text: 'momoclotv が配信を開始しました'
            )
            @status = 'live'
          else
            @status = 'offline'
          end
          save_ustream_status
        end

        private

        def load_ustream_status
          @status_path = ENV.fetch('USTREAM_STATUS_PATH')
          if File.exist?(@status_path)
            @status = File.read(@status_path).strip
          else
            @status = 'offline'
          end
        end

        def save_ustream_status
          File.write(@status_path, @status)
        end

        def on_air?
          conn = Faraday::Connection.new(url: 'https://api.ustream.tv/json/channel/momoclotv/getValueOf/status') do |faraday|
            faraday.request  :url_encoded
            faraday.response :logger, Linebot::Mcz.logger
            faraday.adapter  Faraday.default_adapter
          end

          response = conn.get do |req|
            req.params['key'] = ENV.fetch('USTREAM_API_KEY')
          end
          result = JSON.parse(response.body)
          result['results'] == 'live'
        end

        def user_mids
          Linebot::Mcz::Model::User.all.pluck(:mid)
        end
      end
    end
  end
end
