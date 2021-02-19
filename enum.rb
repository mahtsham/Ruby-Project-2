module Enumerable
  def my_each
    length = self.length
    length.times do |n|
      yield(self[n])
    end
    self
  end
end
