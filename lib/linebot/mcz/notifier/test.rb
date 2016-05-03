module Linebot
  module Mcz
    module Notifier
      class Test
        def notify(mid = nil)
          to_mid = mid
          Linebot::Mcz.client.send_text(
              to_mid: to_mid,
              text: "テストです(* ˘ω˘)"
          )
        end
      end
    end
  end
end
