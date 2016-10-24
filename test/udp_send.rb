#!/usr/bin/env ruby

require "socket"

def send(i)
    msg = [{"name":"Kigi"},{"score":20},{"difficult":0},{"character":2}]

    file = File.open("send.txt","w")
    file.puts(msg)
    file.close
    udp = UDPSocket.open()

    socketaddr = Socket.pack_sockaddr_in(8080,"127.0.0.1")
    msg =   msg.to_s
    udp.send(msg,0,socketaddr)

    udp.close
end

loop do

  3.times do |i|
   send(i)
   sleep(3)
  end
end


