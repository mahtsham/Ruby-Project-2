module Enumerable
  def my_each
    length = self.length
    length.times do |n|
      yield(self[n])
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    array = to_a
    array.length.times { |n| yield(array[n], n) }
    self
  end

  def my_select
    result = []
    my_each do |i|
      result.push(i) if yield(i)
    end
    result
  end

  def my_all?(proc = nil)
    ar = self
    return ar.all?(proc) if proc

    if block_given?
      ar.my_each do |i|
        next unless (yield i) == false

        return false
      end
      return true
    end

    return false if ar.include? false or ar.include? nil

    true
  end
end


puts
puts '=========Test Cases========='
puts
puts 'my_each'
print [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
puts

puts
puts 'my_each_with_index'
print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
puts

puts 'my_select'
p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
p [0, 2018, 1994, -7].my_select(&:positive?) # => [2018, 1994]
p [6, 11, 13].my_select(&:odd?) # => [11, 13]
puts

puts 'my_all?'
p [3, 5, 7, 11].my_all?(&:odd?) # => true
p [-8, -9, -6].my_all?(&:negative?) # => true
p [3, 5, 8, 11].my_all?(&:odd?) # => false
p [-8, -9, -6, 0].my_all?(&:negative?) # => false
# test cases required by tse reviewer
p [1, 2, 3, 4, 5].my_all? # => true
p [1, 2, 3].my_all?(Integer) # => true
p %w[dog door rod blade].my_all?(/d/) # => true
p [1, 1, 1].my_all?(1) # => true
