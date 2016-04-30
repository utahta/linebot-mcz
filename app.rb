$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__)) unless $LOAD_PATH.include?(File.expand_path('../lib', __FILE__))
require 'bundler/setup'
require 'sinatra'
require 'linebot/mcz'

post '/callback' do
  signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
  unless Linebot::Mcz::Client.new.validate_signature(request.body.read, signature)
    error 400 do 'Bad Request' end
  end

  receive_request = Line::Bot::Receive::Request.new(request.env)

  receive_request.data.each do |message|
    case message.content
      when Line::Bot::Operation::AddedAsFriend
        Linebot::Mcz::Scheduler::AddUser.perform_async(message.from_mid)
      when Line::Bot::Operation::BlockedAccount
        Linebot::Mcz::Scheduler::DeleteUser.perform_async(message.from_mid)
      when Line::Bot::Message::Text
        member = %w(玉井詩織 百田夏菜子 有安杏果 佐々木彩夏 高城れに)
        text = message.content[:text]
        search_word = nil
        search_word = member.sample if text.match(/誰(か|でも)/)
        search_word = member[0] if text.match(/玉井|[たタ][まマ][いイ]|[しシ][おオ][りリ][んン]?|詩織|玉さん|[たタ][まマ]さん/)
        search_word = member[1] if text.match(/百田|[もモ][もモ][たタ]|[夏かカ][菜なナ][子こコ]/)
        search_word = member[2] if text.match(/有安|[あア][りリ][やヤ][すス]|[もモ][もモ][かカ]|杏果/)
        search_word = member[3] if text.match(/佐々木|[さサ][さサ][きキ]|[あア][やヤ][かカ]|彩夏|[あア]ー[りリ][んン]/)
        search_word = member[4] if text.match(/高城|[たタ][かカ][ぎギ]|[れレ][にニ]/)

        Linebot::Mcz::Scheduler::SendImage.perform_async(message.from_mid, search_word)
    end
  end
  'OK'
end
