require_relative '../enumerables'
describe Enumerable do
  my_array = [1, 2, 3, 4, 5]
  describe '#my_each' do
    it 'iterates and return array' do
      expect(my_array.my_each { |x| x }).to eq([1, 2, 3, 4, 5])
    end
    it 'iterates and return array for not matched result' do
      expect(my_array.my_each { |x| x }).to_not eq([1, 2, 3, 4])
    end
    it 'calculate sum of array' do
      sum = 0
      my_array.my_each { |x| sum = x + sum }
      expect(sum).to eq(15)
    end
  end
  describe '#my_each_with_index' do
    it 'iterates and return array' do
      expect(my_array.my_each_with_index { |e, v| "#{e} : #{v}" }).to eql([1, 2, 3, 4, 5])
    end
    it 'iterates and return array for not matched result' do
      expect(my_array.my_each_with_index { |e, v| "#{e} : #{v}" }).to_not eql([1, 2, 3, 4])
    end
    it 'calculate sum of array' do
      sum = 0
      my_array.my_each_with_index { |x, _v| sum = x + sum }
      expect(sum).to eq(15)
    end
  end
  describe '#my_select' do
    it 'return even numbers' do
      expect(my_array.my_select(&:even?)).to eql([2, 4])
    end
    it 'return odd numbers' do
      expect(my_array.my_select(&:odd?)).to eql([1, 3, 5])
    end
  end
  describe '#my_all?' do
    it 'return true if all array is odd' do
      expect([3, 5, 7, 11].my_all?(&:odd?)).to eql(true)
    end
    it 'return false if all array is is not odd' do
      expect([2, 4, 8, 16].my_all?(&:odd?)).to eql(false)
    end
  end
  describe '#my_any?' do
    it 'return true if array has any even numbers' do
      expect(my_array.my_any?(&:even?)).to eql(true)
    end
    it 'return false if array has not any numbers greater than 5' do
      expect(my_array.my_any? { |n| n > 5 }).to eql(false)
    end
  end
  describe '#my_none?' do
    it 'return false if array has any even numbers' do
      expect(my_array.my_none?(&:even?)).to eql(false)
    end
    it 'return true if array not has integer 6' do
      expect(my_array.my_none?(6)).to eql(true)
    end
  end
  describe '#my_count' do
    it 'return count of even numbers in array' do
      expect(my_array.my_count(&:even?)).to eql(2)
    end
    it 'return count of odd numbers in array' do
      expect(my_array.my_count(&:odd?)).to eql(3)
    end
    it 'return count of total array' do
      expect(my_array.my_count).to eql(5)
    end
  end
  describe '#my_map?' do
    it 'return mutiply every element of array with 2' do
      expect(my_array.my_map { |n| 2 * n }).to eql([2, 4, 6, 8, 10])
    end
    it 'return true if value is greater than 3 rather false' do
      expect(my_array.my_map { |x| x > 3 }).to eq([false, false, false, true, true])
    end
  end
  describe '#my_inject' do
    it 'return sum of whole array and parameter' do
      expect(my_array.my_inject(20) { |e, v| e + v }).to eql(35)
    end
    it 'return sum of array' do
      expect(my_array.my_inject { |e, v| e + v }).to eql(15)
    end
    it 'return value is not equal to expected value' do
      expect([1, 3, 5].my_inject { |e, v| e + v }).to_not eql(15)
    end
  end
  describe '#multiply_els' do
    it 'multiplies all element of array and return it' do
      expect(multiply_els(my_array)).to eql(120)
    end
    it 'multiplies all element of array and return it' do
      expect(multiply_els([1, 2, 6])).to_not eql(120)
    end
  end
end
