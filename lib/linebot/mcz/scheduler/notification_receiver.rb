module Linebot
  module Mcz
    module Scheduler
      class NotificationReceiver
        include Sidekiq::Worker

        def initialize
          @logger = Linebot::Mcz::Logger.new
        end

        def perform(service)
          @logger.info("received notification from #{service}")

          Linebot::Mcz::Notifier::Blog.new.notify
        end
      end
    end
  end
end
