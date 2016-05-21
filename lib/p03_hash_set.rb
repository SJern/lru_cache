require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    if @count > num_buckets
      resize!
    end
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    double_bucket = num_buckets * 2
    temp_array = Array.new(double_bucket) { Array.new }
    @store.each_with_index do |bucket, idx|
      bucket.each do |el|
        temp_array[el.hash % double_bucket] << el
      end
    end
    @store = temp_array
  end
end
