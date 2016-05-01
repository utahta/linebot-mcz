module Linebot
  module Mcz
    module Scheduler
      class NotificationReceiver
        include Sidekiq::Worker

        def perform(service)
          Linebot::Mcz.logger.info("received notification from #{service}")

          Linebot::Mcz::Notifier::ChannelItems.new.notify
        end
      end
    end
  end
end
