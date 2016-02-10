require 'pry'
require 'csv'
require_relative 'node'
class BST
  attr_accessor :root
  def initialize(root = nil)
    @root = root
  end

  def root?
    if @root == nil
      nil
    else
      @root.data
    end
  end

  def include?(value, current = @root)
    if current == nil
      false

    elsif value == current.data[1]
      true

    elsif value < current.data[1]
      include?(value, current.lchild)

    else
      include?(value, current.rchild)
    end
  end


  # simple recursion using base case and changing
  # recursive call

  # def insert(name, score, current = @root)
  #   if @root == nil
  #     @root = Node.new(name, score)
  #
  #   elsif current == nil
  #     current = Node.new(name, score)
  #
  #   elsif score < current.data[1]
  #     insert(name, score, current.lchild)
  #
  #   else
  #     insert(name, score, current.rchild)
  #   end
  # end


  # next method uses a base non-recursive insert method
  # and a recursive insert_helper method

  # def insert(name, score, current = @root)
  #   if root? == nil
  #     @root = Node.new(name, score)
  #
  #   else
  #     insert_helper(name, score, @root)
  #   end
  # end
  #
  # def insert_helper(name, score, current)
  #   if current == nil
  #     current = Node.new(name, score, current)
  #
  #   elsif score < current.data[1]
  #     insert_helper(name, score, current.lchild)
  #
  #   else
  #     insert_helper(name, score, current.lchild)
  #   end
  # end

  def insert(name, score, current = @root, depth = 0)
    if root? == nil
      @root = Node.new(name, score)
      depth

    elsif score < current.data[1]
      depth += 1
      if current.lchild == nil
        current.lchild = Node.new(name, score)
        depth
      else
        insert(name, score, current.lchild, depth)
      end

    elsif score > current.data[1]
      depth += 1
      if current.rchild == nil
        current.rchild = Node.new(name, score)
        depth
      else
        insert(name, score, current.rchild, depth)
      end
    end
  end

  def depth_of(value, current = @root, depth = 0)
    if @root == nil
      return nil
    else
      if value == current.data[1]
        return depth
      elsif value < current.data[1]
        depth += 1
        depth_of(value, current.lchild, depth)
      else
        depth += 1
        depth_of(value, current.rchild, depth)
      end
    end
  end

  def max(current = @root)
    if current.rchild == nil
      return { current.data[0] => current.data[1] }
    else
      max(current.rchild)
    end
  end

  def min(current = @root)
    if current.lchild == nil
      return { current.data[0] => current.data[1] }
    else
      min(current.lchild)
    end
  end

  def sort(current = @root)
    @sorted = []

    if current == nil
      nil
    else
      sort_help(current)
    end
    return @sorted
  end

  def sort_help(current)
    if current.lchild != nil
      sort_help(current.lchild)
    end

    @sorted << { current.data[0] => current.data[1] }

    if current.rchild != nil
      sort_help(current.rchild)
    end
    return @sorted
  end

  def load(file)
    temp = CSV.read(file)
    temp.count do |array|
      if include?(array[0].to_i) != true
        insert(array[1].lstrip, array[0].to_i)
      end
    end
  end

  def health
    # TODO
  end

  def leaves
    @leaves = 0

    if @root == nil
      return nil
    else
      leaves_helper(@root)
    end

    return @leaves
  end

  def leaves_helper(current)
    if current.lchild == nil && current.rchild == nil
      @leaves +=1
    end

    if current.lchild != nil
      leaves_helper(current.lchild)
    end

    if current.rchild != nil
      leaves_helper(current.rchild)
    end
    @leaves
  end

  def height
    @height = 0

    if @root == nil
      return nil

    elsif @root.lchild == nil && @root.rchild == nil
      return 0
    else
      height_helper(@root)
    end

    return @height
  end

  def height_helper(current)
    if current == nil
      return @height
    end
    depth = depth_of(current.data[1])
    height_helper(current.lchild)
    @height = depth if depth > @height
    height_helper(current.rchild)
    return @height
  end

  def health(depth)
    @health_info = []
    @node = []
    if @root == nil
      return nil

    elsif depth == 0
      node << @root.data[1]; node << 0; node << 100
      @health_info << node
      return @health_info
    else
      health_helper(value, @root)
    end
  end

  def health_helper(value, current, info, node)
    if depth_of(current) == value
      node << current.data[1]; node << 0; node << 100
      @health_info << node
      return @health_info
    end

    if current.lchild != nil
      health_helper(current.lchild)
    end

    if current.rchild != nil
      health_helper(current.rchild)
    end
    return @health_info
  end

end
