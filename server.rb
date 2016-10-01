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
dbctrl = Dbctrl.new(jsonmake)

if ARGV[0] == "-t" then
  dbctrl.test_input
elsif ARGV[0] == nil then
  dbctrl.udp_receive
end



