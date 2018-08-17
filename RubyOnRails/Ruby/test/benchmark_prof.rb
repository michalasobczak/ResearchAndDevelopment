N = 10_000_000
i = 0
arr = []

option = ARGV[0].to_i

if option == 1 then
  N.times do
    i = i + 1
    arr << 1  
  end
elsif option == 2
  N.times do  
    arr[(i+=1)] = 1
  end
elsif option == 3
  N.times do    
    i+=1
    arr << 1  
  end
end
