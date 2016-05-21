require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    delete(key) if include?(key)
    @count += 1
    if @count > num_buckets
      resize!
    end
    @store[key.hash % num_buckets].insert(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @count -= 1
    @store[key.hash % num_buckets].remove(key)
  end

  def each
    @store.reverse_each do |list|
      list.each do |link|
        yield(link.key, link.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    double_bucket = num_buckets * 2
    temp_store = Array.new(double_bucket) { LinkedList.new }
    self.each do |key, val|
      temp_store[key.hash % double_bucket].insert(key, val)
    end
    @store = temp_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
