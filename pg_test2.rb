require 'pg'

# Hash指定のパターン
db = 'postgres'
host = 'localhost'
user ='postgres'
password = 'naoko1128'
port = 5432

conn = PG::Connection.new(host: host, port: port, dbname: db, user: user, password: password)

#result = conn.exec_params("INSERT INTO test (name, food) VALUES ('kei','おにぎり');")
result = conn.exec_params("INSERT INTO mydb (name) VALUES ('kei');")
result = conn.exec_params("select * from mydb;")
p result.values
