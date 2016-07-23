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
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def last # most recent
    empty? ? nil : @tail.prev
  end

  def first # least recent
    empty? ? nil : @head.next
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
     self.each { |link| return link.val if link.key == key }
     nil
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def insert(key, val)
    each { |link| return link.val = val if link.key == key }
    insert_node(key, val)
    # node = Link.new(key, val)
    # @tail.prev.next = node
    # node.prev = @tail.prev
    # node.next = @tail
    # @tail.prev = node
  end

  def insert_node(key, val)
    node = Link.new(key, val)
    @tail.prev.next = node
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev = node
  end

  def remove(key)
    return nil unless include?(key)
    node = nil
    self.each do |link|
      node = link if link.key == key
    end
    # node.prev.next, node.next.prev = node.next, node.prev
    remove_node(node)
  end


  def remove_node(node)
    node.prev.next, node.next.prev = node.next, node.prev
  end

  def each
    start = first
    until start == nil
      yield(start)
      start = start.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
