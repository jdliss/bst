require 'pry'
require_relative 'node'
class BST
  attr_reader :root
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
    else
      if value == current.data[1]
        true
      elsif value < current.data[1]
        if current.lchild == nil
          false
        else
          current = current.lchild
          include?(current.data[1], current)
        end
      else
        if current.rchild == nil
          false
        else
          current = current.rchild
          include?(current.data[1], current)
        end
      end
    end
  end

  def insert(name, score, current = @root)
    if root? == nil
      @root = Node.new(name, score)

    elsif score < current.data[1]
      if current.lchild == nil
        current.lchild = Node.new(name, score)
      else
        current = current.lchild
        insert(name, score, current)
      end

    elsif score > current.data[1]
      if current.rchild == nil
        current.rchild = Node.new(name, score)
      else
        current = current.rchild
        insert(name, score, current)
      end
    end
  end

  def depth_of(value, current = @root, depth = 0)
    if @root == nil
      return "Tree empty"
    else
      if value == current.data[1]
        return depth
      elsif value < current.data[1]
        depth += 1
        current = current.lchild
        depth_of(value, current, depth)
      else
        depth += 1
        current = current.rchild
        depth_of(value, current, depth)
      end
    end
  end

  def max(current = @root)
    if current.rchild == nil
      return { current.data[0] => current.data[1] }
    else
      current = current.rchild
      max(current)
    end
  end

  def min(current = @root)
    if current.lchild == nil
      return { current.data[0] => current.data[1] }
    else
      current = current.lchild
      min(current)
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

end


@root = Node.new("Movie", 10)
@tree = BST.new
@tree.insert("The Godfather", 75)
@tree.insert("The Simpsons Movie", 100)
@tree.insert("Star Wars", 90)
@tree.insert("Scary Movie", 30)
@tree.insert("Saving Private Ryan", 85)
@tree.insert("Goonies", 0)
@tree.insert("Lord of the Rings", 80)
@tree.insert("Lord of the Rings 2", 82)
@tree.insert("Goosebumps", 1)
@tree.insert("Pulp Fiction", 200)

@tree.sort
