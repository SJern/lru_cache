require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_id = 1
    self.each_with_index do |num, idx|
      hash_id += num.hash * idx.hash
    end
    hash_id
  end
end

class String
  def hash
    hash_id = 2
    idx = 0
    while idx < length
      hash_id += self[idx].bytes.first.hash * idx.hash
      idx += 1
    end
    hash_id
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_id = 3
    self.to_a.sort.each_with_index do |array, idx|
      hash_id += array.hash * idx.hash
    end
    hash_id
  end
end
