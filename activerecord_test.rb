require 'active_record'
require 'dotenv/load'

# ---接続の書式---
#ActiveRecord::Base.establish_connection(
#  adapter:  "postgresql",
#  host:     "",
#  username: "myusername",
#  password: "",
#  database: "test"
#)
# ---//接続の書式---

#環境変数を使って接続する
ActiveRecord::Base.establish_connection(
    adapter:  ENV['myadapter'],
    host:     "",
    username: ENV['myusername'],
    password: "naoko1128",
    database: ENV['mydatabase']
)

#クラスをつくる クラス名はDB名の一文字目を大文字にする
class Test < ActiveRecord::Base
end

#1行目のレコードを呼び出す
first_tests = Test.first
#全てのレコードを呼び出す
all_tests = Test.all

puts "レコードの書式を表示"
p first_tests

puts "レコードの内容をカラム別に呼び出す"
all_tests.each do |alltest|
    puts "#{alltest['events']} #{alltest['groups']} #{alltest['rank1']} #{alltest['crew_rank1']}"
end
