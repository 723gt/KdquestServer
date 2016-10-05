#!/urs/bin/env ruby

#UDP server in the KD Quest project
#Git repo: https://bitbucket.org/723/sfserver-2016
#Copyright (c) 2016 kobedenshi.ac.jp Procon Club All Rights Reserved. 
#Create by Show Nakamura & Natsumi Yoshioka  

#mylib
require "./lib/dbctrl"
require "./lib/jsonmake"

#object create
jsonmake = Jsonmake.new
dbctrl = Dbctrl.new

if ARGV[0] == "-t" then
  loop do
    mode = dbctrl.test_input
    tbl = dbctrl.db_ctrl
    jsonmake.class_ctrl(tbl,mode)
  end
elsif ARGV[0] == nil then
 loop do
   mode = dbctrl.udp_receive
   tbl = dbctrl.db_ctrl
   jsonmake.class_ctrl(tbl,mode)
 end
end



