gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'binary_search_tree'
require_relative 'node'

class BSTTest < Minitest::Test
  def setup
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
  end

  def test_can_create_new_tree
    assert_kind_of BST, @tree
  end

  def test_can_create_new_node
    node = Node.new
    assert_kind_of Node, node
  end

  def test_can_create_new_node_with_arguments
    node = Node.new("Simpsons", 100)
    assert_equal "Simpsons", node.data[0]
    assert_equal 100, node.data[1]
  end

  def test_is_there_a_root
    assert_kind_of Array, @tree.root?
  end

  def test_node_has_data
    assert_kind_of String, @root.data[0]
    assert_kind_of Fixnum, @root.data[1]
  end

  def test_can_find_node_in_tree
    assert @tree.include?(85)
  end

  def test_can_insert_node_in_tree
    assert_equal true, @tree.include?(100)
    assert_equal true, @tree.include?(30)
    assert_equal true, @tree.include?(82)
    assert_equal true, @tree.include?(0)
  end

  def test_can_find_depth
    assert_equal 0, @tree.depth_of(75)
    assert_equal 1, @tree.depth_of(100)
    assert_equal 2, @tree.depth_of(90)
    assert_equal 1, @tree.depth_of(30)
    assert_equal 2, @tree.depth_of(0)
    assert_equal 3, @tree.depth_of(85)
    assert_equal 4, @tree.depth_of(80)
    assert_equal 5, @tree.depth_of(82)
  end

  def test_can_find_max
    assert_equal 200, @tree.max
  end

  def test_can_find_mind
    assert_equal 0, @tree.min
  end

  def test_can_sort
    assert_equal [], @tree.sort
  end


end
