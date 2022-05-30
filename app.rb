require 'sinatra'



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

