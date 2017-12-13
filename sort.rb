require 'csv'
require 'benchmark'

CSV_FILE = File.expand_path('../datasets/ted_main.csv', __FILE__ )
COLUMN = 'views'

data = CSV.read(CSV_FILE, headers: true)

# sort.rb:10:in `[]': no implicit conversion of String into Integer (TypeError)
def ruby_sort(array, column)
  array.sort_by { |i| array[i][column].to_i <=> array[i+1][column].to_i }
end

def bubble_sort(array, column)
  n = array.length
  loop do
    swapped = false

    (n-1).times do |i|
      if array[i][column].to_i > array[i+1][column].to_i
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end

    break unless swapped
  end

  array
end

def insertion_sort(array, column)
  (array.length).times do |j|
    while j > 0
      if array[j-1][column].to_i > array[j][column].to_i
        array[j], array[j-1] = array[j-1], array[j]
      else
        break
      end
      j-=1
    end
  end
  array
end

# For 'views' 19.840000   0.020000  19.860000 ( 19.878966)
# For 'comments' 9.540000   0.010000   9.550000 (  9.562376)
# puts Benchmark.measure { bubble_sort(data, COLUMN) }

# For 'views' 4.630000   0.010000   4.640000 (  4.638429)
# From 'comments' 3.600000   0.010000   3.610000 (  3.616539)
# puts Benchmark.measure { insertion_sort(data, COLUMN) }

puts Benchmark.measure { ruby_sort(data, COLUMN) }