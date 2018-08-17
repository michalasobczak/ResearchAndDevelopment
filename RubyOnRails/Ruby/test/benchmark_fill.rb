require 'get_process_mem'

mem_i = GetProcessMem.new
puts mem_i.inspect

N = 4_000_000_000
arr = []
i=0
tmp_arr = [1,1,1,1,1,1,1,1,1,1,
           1,1,1,1,1,1,1,1,1,1,
           1,1,1,1,1,1,1,1,1,1,
           1,1,1,1,1,1,1,1,1,1,
           1,1,1,1,1,1,1,1,1,1]

N.times do
  if i % 10_000_000 == 0 then
    tmp = GetProcessMem.new
    puts tmp.inspect
  end
  arr << tmp_arr
  i+=1
end

mem_j = GetProcessMem.new
puts mem_j.inspect
