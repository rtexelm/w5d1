class HashSet
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
    hash = num.hash
    index = hash % @store.length
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
