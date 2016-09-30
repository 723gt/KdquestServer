#!/urs/bin/env ruby

require "./lib/bdctrl"
require "./lib/jsonmake"

jsonmake = Jsonmake.new
dbctrl = Dbctrl.new(jsonmake)

if ARGV[0] == nil then
  dbctrl.udp_receive
elsif ARGV[0] == "t"
  db.test_input
end



