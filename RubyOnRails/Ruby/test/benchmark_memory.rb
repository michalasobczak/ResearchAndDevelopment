require 'minitest/autorun'
require 'benchmark'

N = 100_000

class BenchmarkMemoryTest < Minitest::Test

  
  def test_mem_arr
    arr = []
    i = 0
    time = Benchmark.realtime do
      N.times do
        if i % 1_000_000 == 0 then puts i.to_s end
        arr << 1
        i = i + 1
      end
    end
    puts 'test_mem_arr=' + time.to_s
  end # test_mem_arr
  
  
  def test_mem_str
    time = Benchmark.realtime do
      limit = N
      str = "*" * limit   
    end
    puts 'test_mem_str=' + time.to_s
  end # test_mem_str
  
   
end
