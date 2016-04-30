module Linebot
  module Mcz
    module Scheduler
      class DeleteUser
        include Sidekiq::Worker

        def initialize
          @logger = Linebot::Mcz::Logger.new
        end

        def perform(mid)
          Linebot::Mcz::Database.connect
          user = Linebot::Mcz::Model::User.where(mid: mid).take
          user.destroy unless user.nil?

          client = Linebot::Mcz::Client.new
          client.send_text(to_mid: mid, text: '通知ノフ設定オフにしました（・Θ・）')
          @logger.info('通知ノフ設定オフにしました')
        end
      end
    end
  end
end
