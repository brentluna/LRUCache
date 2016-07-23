class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 666 if self.empty?
    self.map {|el| el.hash.abs.to_s }.join("").to_i
  end
end

class String
  def hash
    self.chars.map{|letter|letter.ord.to_s}.join("").to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    ords_arr = self.keys.sort.map {|key| key.to_s.ord.to_s}
    ords_arr.join("").to_i.hash
  end
end
