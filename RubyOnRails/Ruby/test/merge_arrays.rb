def merge_arrays(a, b)
  # build a holder array that is the size of both input arrays
  # O(n) space
  result = []

  # get lower head value
  if a[0] < b[0]
    result << a.shift
  else
    result << b.shift
  end

  # check to see if either array is empty
  if a.length == 0
    return result + b
  elsif b.length ==0
    return result + b
  else
    return result + merge_arrays(a, b)
  end
      
end
