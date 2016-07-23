class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    idx = 0
    while idx < capacity
      return true if @store[idx] == val
      idx += 1
    end
    false
  end

  def push(val)
    idx = 0
    while idx < capacity
      if @store[idx].nil?
        @store[idx] = val
        @count += 1
        break
      end
      idx += 1
    end
  end

  def unshift(val)
    resize! if ((@count + 1) >= capacity)

    new_store = StaticArray.new(capacity)
    new_store[0] = val
    idx = 0


    while idx < capacity - 1
      new_store[idx + 1] = @store[idx]
      idx += 1
    end
    @count += 1
    @store = new_store
  end

  def pop
    idx = capacity - 1
    while idx >= 0
      unless @store[idx].nil?
        el = @store[idx]
        @store[idx] = nil
        @count -= 1
        return el
      end
      idx -= 1
    end

  end

  def shift
  end

  def first
  end

  def last
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_arr = StaticArray.new(capacity * 2)
    idx = 0
    while idx < capacity
      new_arr[idx] = @store[idx]
      idx += 1
    end
    @store = new_arr
  end
end
