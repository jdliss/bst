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

  def create_root(name, score)
    if @root.nil?
      @root = Node.new(name, score)
    end
  end

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

  def insert(name, score, current = @root)
    if root? == nil
      @root = Node.new(name, score)

    elsif score < current.data[1]
      if current.lchild == nil
        current.lchild = Node.new(name, score)
      else
        insert(name, score, current.lchild)
      end

    elsif score > current.data[1]
      if current.rchild == nil
        current.rchild = Node.new(name, score)
      else
        insert(name, score, current.rchild)
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

  def leaves(current = @root)
    @leaves = 0

    if current == nil
      return nil
    else
      leaves_helper(current)
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

  def height(current = @root)
    @height = 0

    if current == nil
      return nil

    elsif current.lchild == nil && current.rchild == nil
      return 0
    else
      height_helper(current)
    end

    return @height
  end

  def height_helper(current)
    if current.lchild != nil
      @height += 1
      height_helper(current.lchild)

    elsif current.rchild != nil
      @height += 1
      height_helper(current.rchild)
    end
    return @height
  end





end
