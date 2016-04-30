module Linebot
  module Mcz
    module Database
      def self.connect
        ActiveRecord::Base.establish_connection(
            adapter: 'mysql2',
            host:     ENV.fetch('DB_HOST'),
            username: ENV.fetch('DB_USERNAME'),
            password: ENV.fetch('DB_PASSWORD'),
            database: ENV.fetch('DB_NAME'),
        )
      end
    end
  end
end

