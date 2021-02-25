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
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
end
