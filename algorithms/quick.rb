def quicksort(arr, column)
  return arr if arr.empty?
  index = rand(arr.length)
  p = arr.delete_at(index)
  a,b = arr.partition.each_with_index { |_, i| arr[i][column].to_i < p[column].to_i }
  arr.insert(index, p)
  return [*quicksort(a, column), p, *quicksort(b, column)]
end