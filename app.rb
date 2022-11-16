require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
#require 'bundler/setup'
#require 'puma'
db = 'postgres'
host = 'localhost'
user ='postgres'
password = 'naoko1128'
port = 5432
conn = PG::Connection.new(host: host, port: port, dbname: db, user: user, password: password)

#提出側
get '/' do
  erb :index
end

#受け取り
post '/recieve' do
  year = params[:year]
  month = params[:month]
  name = params[:name]
  comment = params[:comment]
  time = params[:time].split(",")
  id = time.drop(1).map(&:to_i)
  id.each do |i|
    x = i%12+10
    y = (i-x+22)/12
    result = conn.exec_params("INSERT INTO mydb (dt,name,comment,time) VALUES ('#{year}-#{month}-#{y}','#{name}','#{comment}','#{x}');")
    #result = conn.exec_params("select * from mydb WHERE dt>'2022-10-01';") 
    #p result.values
  end
  erb :recieve
end

#管理者側×

def query_shift_table(conn,date)
  result = conn.exec_params("select name,time from mydb WHERE dt='#{date}';")
  dat=result.values
  #p dat
  if dat.empty? then
    p ''
  else
    h = {}
    dat.each{|name,time|
      if h[name]==nil then
        h[name]=[]
      end
      h[name].push time.to_i
    }
    s = "<table border='1'>"
    s += "<tr bgcolor='#FFC247'>"
    s += "<th></th>"
    s += "<th>10-11</th>"
    s += "<th>11-12</th>"
    s += "<th>12-13</th>"
    s += "<th>13-14</th>"
    s += "<th>14-15</th>"
    s += "<th>15-16</th>"
    s += "<th>16-17</th>"
    s += "<th>17-18</th>"
    s += "<th>18-19</th>"
    s += "<th>19-20</th>"
    s += "<th>20-21</th>"
    s += "<th>21-22</th>"
    h.each do |name, time|
      s += "<tr>"
      s += "<th bgcolor='#FFC247'>#{name}</th>"
      for i in 10..21
        if time.include?(i)
          s += "<td bgcolor='#00BFFF'></td>"
        else
          s += "<td></td>"
        end
      end
    end
    s += "</table>"
    return s
  end
end

get '/recieve/admin' do
  y=Time.now.year
  m=Time.now.month
  redirect ("/recieve/admin/#{y}/#{m}")
end

get '/recieve/admin/:year/:month' do
  y=params['year'].to_i
  m=params['month'].to_i
  @r = "#{m-1}"
  @n = "#{m+1}"
  @tables =''
  @tables += "<br>"
  (01..31).each do |d|
    if Date.valid_date?(y, m, d) and 
      @tables += "<br>"
      @tables += "#{m}/#{d}"
      @tables += "<br>"
      @tables += query_shift_table(conn,"#{y}-#{m}-#{d}")
    end
  end
  erb :admin
end

#シフト一覧表
def query_shift_table(conn,date)
  result = conn.exec_params("select name,time from mydb WHERE dt='#{date}';")
  dat=result.values
  if dat.empty? then
    p ''
  else
    h = {}
    dat.each{|name,time|
      if h[name]==nil then
        h[name]=[]
      end
      h[name].push time.to_i
    }
    s = "<table border='1'>"
    s += "<tr bgcolor='#FFD683'>"
    s += "<th></th>"
    s += "<th>10-11</th>"
    s += "<th>11-12</th>"
    s += "<th>12-13</th>"
    s += "<th>13-14</th>"
    s += "<th>14-15</th>"
    s += "<th>15-16</th>"
    s += "<th>16-17</th>"
    s += "<th>17-18</th>"
    s += "<th>18-19</th>"
    s += "<th>19-20</th>"
    s += "<th>20-21</th>"
    s += "<th>21-22</th>"
    h.each do |name, time|
      s += "<tr>"
      s += "<th bgcolor='#FFD683'>#{name}</th>"
      for i in 10..21
        if time.include?(i)
          s += "<td onclick='bgSwap(this)' bgcolor='#83C1FF'></td>"
        else
          s += "<td></td>"
        end
      end
    end
    s += "</table>"
    return s
  end
end

get '/recieve/view_log' do
  y=Time.now.year
  m=Time.now.month
  redirect ("/recieve/view_log/#{y}/#{m}")
end

get '/recieve/view_log/:year/:month' do 
  y = params['year'].to_i
  m = params['month'].to_i
  if 1<=m and m<=12
    r1 = "#{m-1}"
    n1 = "#{m+1}"
    r2 = y
    n2 = y
  elsif m=0
    r1 = 0
    n1 = 0
    r2 = 0
    n2 = 0
  end
  @r1=r1
  @n1=n1
  @r2=r2
  @n2=n2
  @tables =''
  @tables += "<br>"
  (01..31).each do |d|
    if Date.valid_date?(y, m, d)
      @tables += "<br>"
      @tables += "#{m}/#{d}"
      @tables += "<br>"
      @tables += query_shift_table(conn,"#{y}-#{m}-#{d}")
    end
  end
  erb :view_log
end


