require 'sinatra'
require 'bundler'
Bundler.require
require 'rss'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class User <ActiveRecord::Base
  validates_presence_of :name
 # validates_presence_of :url
end


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

