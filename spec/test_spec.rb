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
  it 'return even numbers' do
    expect(my_array.my_any?() { |n| n.even? }).to eql(true)
  end
  it 'return even numbers' do
    expect(my_array.my_any?() { |n| n > 5 }).to eql(false)
  end
end
end
