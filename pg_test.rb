require 'pg'

# Hash指定のパターン
db = 'database'
host = 'db'
user ='user'
password = 'password'
port = 5432

conn = PG::Connection.new(host: host, port: port, dbname: db, user: user, password: password)
