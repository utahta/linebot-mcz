module Linebot
  module Mcz
    module Scheduler
      class AddUser
        include Sidekiq::Worker

        def perform(mid)
          Linebot::Mcz::Database.connect
          begin
            user = Linebot::Mcz::Model::User.new(mid: mid)
            user.save!
          rescue ActiveRecord::RecordNotUnique => e
            Linebot::Mcz.logger.info("AddUser: #{e.message}")
          end

          Linebot::Mcz.client.send_text(to_mid: mid, text: '通知ノフ設定オンにしました（・Θ・）')
          Linebot::Mcz.logger.info('通知ノフ設定オンにしました')
        end
      end
    end
  end
end
