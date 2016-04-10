module Linebot
  module Mcz
    class Logger < ::Logger
      def initialize
        super(STDOUT)
        self.level = WARN
      end
    end
  end
end
