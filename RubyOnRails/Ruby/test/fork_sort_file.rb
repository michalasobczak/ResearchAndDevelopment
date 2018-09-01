#***************************
# LIBRARIES                  
#***************************
require 'benchmark'
load 'sort.rb'

#***************************
# DATA                  
#***************************
processes_no = 4
arr_size = 10000
option = ARGV[0].to_s
$sort_index = 0
arr = Array.new(8*arr_size) { (rand*100000).to_i }
#puts arr.inspect
#puts


#***************************
# PROGRAM
#***************************
puts "MAIN #{$$} => START"

# *** BUBBLE SORT **********
if option == 'with-bubble-sort' then
  sorted = nil
  time = Benchmark.realtime do
    sorted = bubble_sort(arr)
    puts "=> bubble_sort"
  end
  sel_print_sorted_arr(sorted)
  puts 'time=' + time.to_s
  puts
end

sleep 1

# *** QUICK SORT **********
puts "=> quicksort"
sorted = nil
pids = []
time2 = Benchmark.realtime do
  arr_size = arr.size
  step  = (arr_size/processes_no)-1
  processes_no.times do |index|
    pid = fork do
      $sort_index = 0
      start = 0
      if index > 0 then start = step*(index)+index end 
      finish = step*(index+1)+index
      res = quicksort(arr[start..finish], 0, step).to_s + '+'
      File.open("tmp/#{$$}", 'w') { |file| file.write(res) }
    end
    pids << pid
  end
  Process.waitall
  pre_sorted = String.new
  pids.each do |pid|
    path = "tmp/#{pid}"
    pre_sorted = pre_sorted + File.readlines(path)[0]
    File.delete(path)
  end
  pre_sorted = pre_sorted + '[]'
  sorted = quicksort(eval(pre_sorted), 0, arr_size-1)
end
sel_print_sorted_arr(sorted)
puts 'time2=' + time2.to_s

puts "MAIN #{$$} => FINISH"

