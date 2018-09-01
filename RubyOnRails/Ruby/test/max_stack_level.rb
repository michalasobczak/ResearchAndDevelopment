def recurse(n)
  return 1 if n == 1
  1 + recurse(n-1)
end

def binary_search
  answer, a, b = 0, 0, 1_000_000_000

  while a<=b
    mid = (a+b)/2
    begin
      recurse(mid)
      answer = mid
      a = mid + 1
    rescue SystemStackError
      b = mid - 1
    end
  end

  answer
end

puts "Max Stack Level: #{binary_search}"
