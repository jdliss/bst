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
    @root.data[1]

  end

end
