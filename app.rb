$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__)) unless $LOAD_PATH.include?(File.expand_path('../lib', __FILE__))
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'faraday'
require 'linebot/mcz'

post '/callback' do
  params = JSON.parse(request.body.read)
  params['result'].each do |msg|
    message_api = Linebot::Mcz::MessageApi.new

    member = %w(玉井詩織 百田夏菜子 有安杏果 佐々木彩夏 高城れに)
    search_word = nil
    search_word = member.sample if msg['content']['text'].match(/誰(か|でも)/)
    search_word = member[0] if msg['content']['text'].match(/玉井|[たタ][まマ][いイ]|[しシ][おオ][りリ][んン]?|詩織|玉さん|[たタ][まマ]さん/)
    search_word = member[1] if msg['content']['text'].match(/百田|[もモ][もモ][たタ]|[夏かカ][菜なナ][子こコ]/)
    search_word = member[2] if msg['content']['text'].match(/有安|[もモ][もモ][かカ]|杏果/)
    search_word = member[3] if msg['content']['text'].match(/佐々木|[さサ][さサ][きキ]|[あア][やヤ][かカ]|彩夏|[あア]ー[りリ][んン]/)
    search_word = member[4] if msg['content']['text'].match(/高城|[たタ][かカ][ぎギ]|[れレ][にニ]/)

    if search_word
      google_custom_api = Linebot::Mcz::GoogleCustomApi.new
      original_content_url, preview_image_url = google_custom_api.search_image(search_word)
      message_api.post_image([msg['content']['from']], original_content_url, preview_image_url)
    else
      kwkm = Linebot::Mcz::Kwkm.new
      original_content_url, preview_image_url = kwkm.image
      message_api.post_image([msg['content']['from']], original_content_url, preview_image_url)
    end
  end
  'OK'
end
