#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

begin
  counter = 0
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    counter = counter + 1
    if counter % 1000 == 0 then
      #puts " [x] Received #{body}"
      puts counter.to_s
    end
  end
rescue Interrupt => _
  connection.close

  exit(0)
end
