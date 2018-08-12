require 'minitest/autorun'
require 'benchmark'

N = 100_000_000


class BenchmarkTest < Minitest::Test

  def test_addition_integer
    i = 1
    time = Benchmark.realtime do
      N.times do
        i = i + 2
      end
    end    
    puts time.to_s
    assert_equal i, 200_000_001
  end # test_addition
  
end
