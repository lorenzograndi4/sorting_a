require 'csv'
require 'benchmark'
require File.expand_path('../algorithms/merge', __FILE__)

CSV_FILE = File.expand_path('../datasets/ted_main.csv', __FILE__ )
COLUMN = 'comments'

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
  @calls = 0
  (array.length).times do |j|
    while j > 0
      if array[j-1][column].to_i > array[j][column].to_i
        array[j], array[j-1] = array[j-1], array[j]
        @calls+=1
      else
        break
      end
      j-=1
      @calls+=1
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

# puts Benchmark.measure { ruby_sort(data, COLUMN) }

array = [
  { 'views' => '22', 'speakers' => '41', 'name' => 'foo' },
  { 'views' => '6666', 'speakers' => '2', 'name' => 'bar' },
  { 'views' => '3333', 'speakers' => '77', 'name' => 'baz' }
]

array_of_hashes = data.map do |row|
  row.to_hash
end.to_a

# For 'views': 0.020000   0.000000   0.020000 (  0.017218)
# For 'comments': 0.010000   0.000000   0.010000 (  0.012994)
# puts Benchmark.measure { mergesort(array_of_hashes, COLUMN) }








