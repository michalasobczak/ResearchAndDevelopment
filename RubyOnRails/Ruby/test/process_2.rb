require "./process"
require "benchmark"

puts Benchmark.measure{
  100.times do |i|
    Mailer.deliver do 
      from    "michalasobczak@gmail.com"
      to      "michalasobczak+1@gmail.com"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end
  end
}