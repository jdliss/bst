class Node
attr_reader :data
attr_accessor :lchild, :rchild

  def initialize(name=nil, score=nil, lchild=nil, rchild=nil, depth=nil)
    @data = [name, score]
    @lchild = lchild
    @rchild = rchild
    @depth = 0
  end
end
