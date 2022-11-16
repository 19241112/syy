require 'pg'

# Hash指定のパターン
db = 'postgres'
host = 'localhost'
user ='postgres'
password = 'naoko1128'
port = 5432

conn = PG::Connection.new(host: host, port: port, dbname: db, user: user, password: password)
#conn.exec_params('SELECT * FROM $1 WHERE ', ['sample'])
#result = conn.exec_params('SELECT * from pg_tables')
#p result.values
result = conn.exec_params("select schemaname, tablename, tableowner 
  from pg_tables 
  where schemaname not like 'pg_%' and schemaname != 'information_schema';")
p result.values
#result = conn.exec_params('SELECT * frome ')
