require 'benchmark'

NTIMES = 10
NUMBER = 24

def main
  i = 0;
  value = 0;
  printf("%d iterations: ", NTIMES)
  NTIMES.times do |index|
    value = fib(NUMBER)
  end
  printf("fibonacci(%d) = %u.\n", NUMBER, value);
end


def fib(x)
  if (x > 2) then
    return (fib(x-1) + fib(x-2))
  else
    return 1
  end
end

time = Benchmark.realtime do
  main()
end

puts "time=" + time.to_s