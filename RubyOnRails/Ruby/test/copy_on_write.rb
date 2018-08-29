data = [1,2,3]

fork do
  sleep 1
  puts "data in child: #{data}"
end

data[0] = "a"
puts "data in parent: #{data}"

Process.waitall
