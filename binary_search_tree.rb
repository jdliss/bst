require 'pry'
require 'csv'
require_relative 'node'
class BST
  attr_accessor :root
  def initialize(root = nil)
    @root = root
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
  #   if  current == nil
  #     @root = Node.new(name, score)
  #
  #   elsif score < current.data[1]
  #     insert(name, score, current.lchild)
  #
  #   else
  #     insert(name, score, current.rchild)
  #   end
  #   0
  # end


  # next method uses a base non-recursive insert method
  # and a recursive insert_helper method

  # def insert(name, score, current = @root)
  #   if root == nil
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
    if root == nil
      @root = Node.new(name, score)
      depth
    else
      insert_helper(name, score, current, depth)
    end
  end

  def insert_helper(name, score, current, depth)
    if score < current.data[1]
      insert_left(name, score, current, depth)

    elsif score > current.data[1]
      insert_right(name, score, current, depth)
    end
  end

  def insert_left(name, score, current, depth)
    depth += 1
    if current.lchild == nil
      current.lchild = Node.new(name, score)
      depth
    else
      insert(name, score, current.lchild, depth)
    end
  end

  def insert_right(name, score, current, depth)
    depth += 1
    if current.rchild == nil
      current.rchild = Node.new(name, score)
      depth
    else
      insert(name, score, current.rchild, depth)
    end
  end


  def depth_of(value, current = @root, depth = 0)
    if @root == nil
      return nil
    else
      depth_of_helper(value, current, depth)
    end
  end

  def depth_of_helper(value, current, depth)
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
    sort_help(current) if current

    # if current == nil
      # nil
    # else
      # sort_help(current)
    # end
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
    @health_info = []; @node = []; @children = 1
    if @root == nil
      return nil

    elsif depth == 0
      childs = children_counter(@root.data[1], @root)
      @node << @root.data[1]; @node << childs + 1; @node << 100
      @health_info << @node
      return @health_info
    else
      health_helper(depth, @root)
      return @health_info
    end
  end


  def health_helper(depth, current)
    if depth_of(current.data[1]) == depth
      @counter = 0
      @counter = children_counter(current.data[1], current) + 1
      @node << current.data[1]
      @node << @counter
      @node << ((@counter / (sort.size.to_f)) * 100).floor
      @health_info << @node
      @node = []
      return @health_info
    end
    child_recursion(depth, current)
  end


  def child_recursion(depth, current)
    if current.lchild != nil
      health_helper(depth, current.lchild)
    end
    if current.rchild != nil
      health_helper(depth, current.rchild)
    end
  end


  def children_counter(start, current)
    if current.data[1] == start
      @counter = 0
    end

    if current.lchild != nil
      @counter += 1
      children_counter(start, current.lchild)
    end

    if current.rchild != nil
      @counter += 1
      children_counter(start, current.rchild)
    end
    return @counter
  end
end
