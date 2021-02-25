module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_each
    return to_enum unless block_given?

    length = size
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
    return to_enum unless block_given?

    result = []
    my_each do |i|
      result.push(i) if yield(i)
    end
    result
  end

  def my_all?(arg = nil)
    a = self
    return a.all?(arg) if arg

    if block_given?
      a.my_each do |i|
        next unless (yield i) == false

        return false
      end
      return true
    end

    return false if a.include? false or a.include? nil

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
    elsif arg[0].is_a? Class
      my_each { |n| return true if n.class.ancestors.include?(arg[0]) }

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
    else
      count = size
    end
    count
  end

  def my_map(arg = nil)
    a = []
    return to_enum unless block_given?

    if arg
      my_each { |e| a.push arg.call(e) }
    else
      my_each { |e| a.push yield(e) }
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
