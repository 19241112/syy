require 'mysql2'

client = Mysql2::client.new(:host => "localhost", :username => "root", :database => "myapp")

sql = "SELECT * FROM ex1"
statement = client.prepare(sql)
results = statement.execute()

results.each do |row|
  p row
end
