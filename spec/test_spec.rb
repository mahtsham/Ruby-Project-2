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



end