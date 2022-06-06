require 'sinatra'
require 'sinatra/reloader' if development?


get '/' do
  erb :index
end
post '/recieve' do
  @name = params[:name]
  erb :recieve
end
get 'admin' do
  erb :admin
end

