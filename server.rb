#!/urs/bin/env ruby

require "./lib/bdctrl"
require "./lib/jsonmake"

dbctrl = Dbctrl.new
jsonmake = Jsonmake.new

if ARGV[0] == nil then
  dbctrl.udp_receive
elsif ARGV[0] == "t"
  db.test_input
end



