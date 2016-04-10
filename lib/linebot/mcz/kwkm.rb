module Linebot
  module Mcz
    class Kwkm
      def initialize
        @images = [
            ['http://president.jp/mwimgs/1/1/220/img_11ed54ac3e1726f1ec51ab00fae410c013756.jpg', 'http://president.jp/mwimgs/1/1/220/img_11ed54ac3e1726f1ec51ab00fae410c013756.jpg'],
            ['http://stat.ameba.jp/user_images/20150124/18/momoclozz5/55/24/j/o0400026713198252557.jpg', 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSjrHzjPXIS12a3PyyQ6yzd7Y7Rb578P1t6Hjgx-qAGrtwsSQQ9'],
            ['http://blog-imgs-65.fc2.com/t/a/k/takagireni555/23674194.jpeg', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTsxx86lc5bOlIAq6-7hsJh2-hTvQHV1OTNZst5cZDmrL0CSLKTHA']
        ]
      end

      def image
        @images.sample
      end
    end
  end
end
