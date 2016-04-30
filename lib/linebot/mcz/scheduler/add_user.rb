module Linebot
  module Mcz
    module Scheduler
      class AddUser
        include Sidekiq::Worker

        def initialize
          @logger = Linebot::Mcz::Logger.new
        end

        def perform(mid)
          Linebot::Mcz::Database.connect
          begin
            user = Linebot::Mcz::Model::User.new(mid: mid)
            user.save!
          rescue ActiveRecord::RecordNotUnique => e
            @logger.info("AddUser: #{e.message}")
          end

          client = Linebot::Mcz::Client.new
          client.send_text(to_mid: mid, text: '通知ノフ設定オンにしました（・Θ・）')
          @logger.info('通知ノフ設定オンにしました')
        end
      end
    end
  end
end
