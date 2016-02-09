require_relative 'node'
class BST
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

  def include?(value)
    if value == @root.data[1]
      true
    elsif value < @root.data[1]
      if @root.lchild == nil
        false
      else
        include?(@root.lchild.data[1])
      end
    else
      if @root.rchild == nil
        false
      else
        include?(@root.rchild.data[1])
      end
    end
  end

  def insert(name, score, current = @root)
    if root? == nil
      @root = Node.new(score, name)

    elsif score < current.data[1]
      if current.lchild == nil
        lchild = Node.new(score, name)
      else
        current = current.lchild
        insert(score, name, current)
      end

    else
      if current.rchild == nil
        rchild = Node.new(score, name)
      else
        current = current.rchild
        insert(score, name, current)
      end
    end
  end
end
