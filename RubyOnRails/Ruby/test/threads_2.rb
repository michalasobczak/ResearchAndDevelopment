def sub1
  i=0
  while
    i = rand(10) + i
    #puts "In thread" 
  end
end

th = Thread.new{sub1}
th1 = Thread.new{sub1}
th2 = Thread.new{sub1}

p Thread.list
th.join

#ps -M  Mac
#ps -LM Linux