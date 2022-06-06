require 'pg'

uri = 'postgres://username:password@host:5432/dbname'

conn = PG::Connection.new(uri)
conn.exec_params('SELECT * FROM $1 WHERE ', ['sample'])
