class Node
attr_reader :data
attr_accessor :lchild, :rchild, :depth

  def initialize(name=nil, score=nil, lchild=nil, rchild=nil)
    @data = [name, score]
    @lchild = lchild
    @rchild = rchild
  end
end
