class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = @head
    until link.next.nil?
      break if link.key == key
      link = link.next
    end
    link.val
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    steven = Link.new(key, val)
    steven.next = @tail
    steven.prev = @tail.prev
    @tail.prev = steven
    steven.prev.next = steven
    steven.val
  end

  def remove(key)
    raise "No such key!" if get(key).nil?
    link = @head
    until link.key == key
      link = link.next
    end
    link.prev.next = link.next
    link.next.prev = link.prev
    link.prev, link.next = nil, nil
  end

  def each(&prc)
    arr = Array.new
    link = @head.next
    until link.next.nil?
      arr << link
      link = link.next
    end
    arr.each(&prc)

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
