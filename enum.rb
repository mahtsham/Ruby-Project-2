module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
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
