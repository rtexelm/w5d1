class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    if num < 0 || num > @store.length - 1
      raise "Out of bounds"
    else
      return true
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if !include?(num)
      self[num] << num
    end
  end

  def remove(num)
    if include?(num)
      index = self[num].index(num)
      self[num].delete_at(index)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % @store.length
    @store[index]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num) && count 
      if count + 1 == num_buckets
        resize!
        self[num] << num
        @count += 1
      else
        self[num] << num
        @count += 1
      end
    end

  end

  def remove(num)
    if include?(num)
      index = self[num].index(num)
      self[num].delete_at(index)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % @store.length
    @store[index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup.flatten
    @store = Array.new(num_buckets * 2) {Array.new}
    
    old_store.each do |num|
      self[num] << num
    end
  end
end

# [1] [2] [3] [4] []
# [1,2,3,4]
# [] [] [] [] [] [] [] [] [] []