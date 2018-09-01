def factorial(n)
  raise InvalidArgument, "negative input given" if n < 0

  return 1 if n == 0
  return factorial(n - 1) * n
end

(1..5000).each do |index|
  puts factorial(index).to_s.size
end
