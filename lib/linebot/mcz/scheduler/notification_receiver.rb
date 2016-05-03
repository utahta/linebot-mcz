module Linebot
  module Mcz
    module Scheduler
      class NotificationReceiver
        include Sidekiq::Worker

        def perform(service)
          Linebot::Mcz.logger.info("received notification from #{service}")

          Linebot::Mcz::Notifier::Blog.new.notify
          Linebot::Mcz::Notifier::AeNews.new.notify
          Linebot::Mcz::Notifier::Youtube.new.notify
        end
      end
    end
  end
end
