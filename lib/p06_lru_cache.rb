require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map.get(key)
      update_link!(link)
    else
      eject! if @max == @map.count
      calc!(key)
    end
    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.insert_node(key, @prc.call(key))
    @map.set(key, @store.last)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    key, val = link.key, link.val
    @store.remove_node(link)
    @store.insert_node(key, val)
    @map.set(key, @store.last)

  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end
