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

def my_any?
  status = false
  my_each do |x|
    return !status if yield(x)
  end
  status
end
# 5. my_any? (example test cases)
puts 'my_any?'
p [7, 10, 3, 5].my_any?(&:even?) # => true
p [7, 10, 4, 5].my_any?(&:even?) # => true
p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
p [7, 11, 3, 5].my_any?(&:even?) # => false
p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
# test cases required by tse reviewer
p [1, nil, false].my_any?(1) # => true
p [1, nil, false].my_any?(Integer) # => true
p %w[dog door rod blade].my_any?(/z/) # => false
p [1, 2, 3].my_any?(1) # => true
p [3, 4, 7, 11].my_any?(Numeric) # => true
p [3, 4, 7, 11].my_any?(Integer) # => true
p %w[jes,umair,jesagain,hello].my_any?('jes') # => false
puts
