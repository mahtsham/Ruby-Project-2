require_relative '../enumerables.rb'
describe Enumerable do
    my_array = [1,2,3,4,5]
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
  expect(my_array.my_each_with_index { |e, v| "#{e} : #{v}"  }).to eql([1, 2, 3, 4, 5])
end
it 'iterates and return array for not matched result' do
    expect(my_array.my_each_with_index { |e, v| "#{e} : #{v}"  }).to_not eql([1, 2, 3, 4])
  end
  it 'calculate sum of array' do
    sum = 0
    my_array.my_each_with_index { |x, v| sum = x + sum }
    expect(sum).to eq(15)
end
end
describe '#my_select' do 
it 'return even numbers' do
 expect(my_array.my_select { |n| n.even? }).to eql([2, 4])
end
it 'return even numbers' do
    expect(my_array.my_select { |n| n.even? }).to_not eql([3, 5])
end
end

end