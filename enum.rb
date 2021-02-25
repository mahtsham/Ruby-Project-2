module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_each
    return to_enum unless block_given?
    length = self.size
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

  def my_all?(arg = nil)
    ar = self
    return ar.all?(arg) if arg

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

  def my_any?(*arg)
    if block_given?
      my_each { |n| return true if yield(n) }

    elsif arg.empty?
      my_each do |v|
        return true if v
      end
      return false

    elsif arg[0].is_a? Regexp
      my_each { |n| return true if arg[0].match(n) }

    else
      my_each { |n| return true if n == arg[0] }
    end

    false
  end

  def my_none?(input = nil, &block)
    !my_any?(input, &block)
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !arg.nil?
      if to_a.include? arg
        to_a.length.times do |i|
          count += 1 if to_a[i] == arg
        end
      end
      count
    end
    count
  end

  def my_map(arg = nil)
    a = []
    return to_enum unless block_given?

    if arg
      my_each { |i| a.push arg.call(i) }
    else
      my_each { |i| a.push yield(i) }
    end
    a
  end

  def my_inject(arg = nil)
    my_each do |n|
      arg = arg ? yield(arg, n) : self[0]
    end
    arg
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end

# puts
# puts "=========Test Cases========="
puts
puts "my_each"
print [1, 2, 3].my_each { |elem| print (elem + 1).to_s + " "} # => 2 3 4
puts

# #2. my_each_with_index
# puts
# puts "my_each_with_index"
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
# puts

# #3. my_select
# puts "my_select"
# p [1,2,3,8].my_select { |n| n.even? } # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# puts

# # 4. my_all? (example test cases)
# puts "my_all?"
# p [3, 5, 7, 11].my_all? { |n| n.odd? } # => true
# p [-8, -9, -6].my_all? { |n| n < 0 } # => true
# p [3, 5, 8, 11].my_all? { |n| n.odd? } # => false
# p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# # test cases required by tse reviewer
# p [1,2,3,4,5].my_all? # => true
# p [1, 2, 3].my_all?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_all?(/d/) # => true
# p [1, 1, 1].my_all?(1) # => true
# puts

# #5. my_any? (example test cases)
# puts "my_any?"
# p [7, 10, 3, 5].my_any? { |n| n.even? } # => true
# p [7, 10, 4, 5].my_any?() { |n| n.even? } # => true
# p ["q", "r", "s", "i"].my_any? { |char| "aeiou".include?(char) } # => true
# p [7, 11, 3, 5].my_any? { |n| n.even? } # => false
# p ["q", "r", "s", "t"].my_any? { |char| "aeiou".include?(char) } # => false
# # test cases required by tse reviewer
# p [1, nil, false].my_any?(1) # => true
# p [1, nil, false].my_any?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_any?(/z/) # => false
# p [1, 2 ,3].my_any?(1) # => true
# p [3,4,7,11].my_any?(Numeric)  # => true
# p [3,4,7,11].my_any?(Integer) # => true
# p %w[jes,umair,jesagain,hello].my_any?('jes') # => false
# puts

# #6. my_none? (example test cases)
# puts "my_none?"
# p [3, 5, 7, 11].my_none? { |n| n.even? } # => true
# p ["sushi", "pizza", "burrito"].my_none? { |word| word[0] == "a" } # => true
# p [3, 5, 4, 7, 11].my_none? { |n| n.even? } # => false
# p ["asparagus", "sushi", "pizza", "apple", "burrito"].my_none? { |word| word[0] == "a" } # => false
# # test cases required by tse reviewer
# p [nil, false, nil, false].my_none? # => true
# p [1, 2 ,3].my_none? # => false
# p [1, 2 ,3].my_none?(String) # => true
# p [1,2,3,4,5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# puts

# #7. my_count (example test cases)
# puts "my_count"
# p [1,4,3,8].my_count { |n| n.even? } # => 2
# p ["DANIEL", "JIA", "KRITI", "dave"].my_count { |s| s == s.upcase } # => 3
# p ["daniel", "jia", "kriti", "dave"].my_count { |s| s == s.upcase } # => 0
# # test cases required by tse reviewer
# p [1,2,3].my_count # => 3
# p [1,1,1,2,3].my_count(1) # => 3
# p (1...5).my_count # => 4
# puts

# #8. my_map
# puts "my_map"
# p [1,2,3].my_map { |n| 2 * n } # => [2,4,6]
# p ["Hey", "Jude"].my_map { |word| word + "?" } # => ["Hey?", "Jude?"]
# p [false, true].my_map { |bool| !bool } # => [true, false]
# my_proc = Proc.new {|num| num > 10 }
# p [18, 22, 5, 6] .my_map(my_proc) {|num| num < 10 } # => true true false false
# puts

# #9. my_inject
# puts "my_inject"
# p [1,2,3,4].my_inject(10) { |accum, elem| accum + elem} # => 20
# p [1,2,3,4].my_inject { |accum, elem| accum + elem} # => 10
# p [5, 1, 2].my_inject("+") # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) {|prod, n| prod * n} # should return 604800