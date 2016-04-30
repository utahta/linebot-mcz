module Linebot
  module Mcz
    module Scheduler
      class DeleteUser
        include Sidekiq::Worker

        def perform(mid)
          Linebot::Mcz::Database.connect
          user = Linebot::Mcz::Model::User.where(mid: mid).take
          user.destroy unless user.nil?

          client = Linebot::Mcz::Client.new
          client.send_text(to_mid: mid, text: '通知ノフ設定オフにしました（・Θ・）')
        end
      end
    end
  end
end
