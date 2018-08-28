require "./process"
require "benchmark"

threads = []

puts Benchmark.measure{
  100.times do |i|
    threads << Thread.new do     
      Mailer.deliver do 
        from    "michalasobczak@gmail.com"
        to      "michalasobczak+1@gmail.com"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end
    end
  end
  threads.map(&:join)
}