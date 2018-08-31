def bubble_sort(array)
  n = array.length
  loop do
    swapped = false
    (n-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end
    break if not swapped
  end
  array
end # bubble_sort

def quicksort(arr, first, last)
  if $sort_index % 1000 == 0 then puts "#{$$} => #{$sort_index.to_s}" end
  $sort_index = $sort_index + 1 
  if first < last
    p_index = partition(arr, first, last)
    quicksort(arr, first, p_index - 1)
    quicksort(arr, p_index + 1, last)
  end
  arr
end # quicksort

def partition(arr, first, last)
  # first select one element from the list, can be any element. 
  # rearrange the list so all elements less than pivot are left of it, 
  # elements greater than pivot are right of it.
  pivot = arr[last]
  p_index = first
  i = first
  while i < last
    if arr[i] <= pivot
      temp = arr[i]
      arr[i] = arr[p_index]
      arr[p_index] = temp
      p_index += 1
    end
    i += 1
  end
  temp = arr[p_index]
  arr[p_index] = pivot
  arr[last] = temp
  return p_index
end # partition

def sel_print_sorted_arr(sorted)
  puts '-> ' + sorted[0].to_s
  puts '-> ' + sorted[1].to_s
  puts '-> ' + sorted[sorted.size-2].to_s
  puts '-> ' + sorted[sorted.size-1].to_s
end # sel_print_sorted_arr(sorted)


