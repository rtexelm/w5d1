class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
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
    @head.next.key == :tail && @tail.prev.key == :head
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil

    # self.each {|node| }
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    prev = @tail.prev
    node = Node.new(key, val)
    node.prev = prev
    node.next = @tail
    prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        prevNode = node.prev
        nextNode = node.next
        prevNode.next = nextNode
        nextNode.prev = prevNode
        break
      end
    end
  end

  def each(&prc)
    #self.each do |node|
    # p node.val
    # end
    node = @head.next
    until node.key == :tail
      prc.call(node)
      node = node.next
    end
    self

    #update
    #while
    #if key is the key you want, node.val 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end



