#!/usr/bin/env ruby
require 'bunny'

2.times do 
  fork do
    connection = Bunny.new(automatically_recover: false)
    connection.start
    channel = connection.create_channel
    queue = channel.queue('hello')

    (1..100_000).each_with_index do |i|
      channel.default_exchange.publish("Hello World! #{i.to_s}", routing_key: queue.name)
      if i % 1000 == 0 then
        puts "#{$$} -> #{i.to_s}'"
      end
    end

    connection.close
  end
end

Process.waitall

