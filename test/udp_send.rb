#!/usr/bin/env ruby

require "socket"

msg = {name:"kigi"},{"score":20},{"difficult":1},{"character":2}
udp = UDPSocket.open()

socketaddr = Socket.pack_sockaddr_in(8080,"127.0.0.1")
msg =   msg.to_s
udp.send(msg,0,socketaddr)

udp.close