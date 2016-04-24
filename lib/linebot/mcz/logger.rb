module Linebot
  module Mcz
    class Logger < ::Logger
      def initialize
        super(STDOUT)
        self.level = INFO
      end
    end
  end
end
