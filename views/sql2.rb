require 'sinatra'

client = Sinatra::client.new(:host => "localhost", :username => "root", :database => "views")

sql = "SELECT * FROM table1"
statement = client.prepare(sql)
results = statement.execute()

results.each do |row|
  p row
end
