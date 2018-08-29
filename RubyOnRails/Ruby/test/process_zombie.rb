fork do
  puts "Zombie: *comes out of grave*"
  puts "Zombie: rahhh...kill me with: $ kill #{$$}"
  loop do
    puts "Zombie (#{$$}): brains..."
    sleep 1
  end
end

puts "Main (#{$$}): finished"
