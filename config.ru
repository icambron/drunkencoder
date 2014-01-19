require 'bundler'
Bundler.require

class App < Sinatra::Base
  get '*' do
    redirect "http://isaaccambron.com/blog"
  end
end

map "/" do
  run App
end
