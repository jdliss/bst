class Node
attr_reader :data, :lchild, :rchild

  def initialize(name="root_node", score=0, lchild=nil, rchild=nil)
    @data = [name, score]
    @lchild = lchild
    @rchild = rchild
  end
end
