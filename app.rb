require 'sinatra'
 
get '/' do
  erb :index
end
post '/recieve' do
  erb :recieve
end
get 'admin' do
  erb :admin
end

