gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'binary_search_tree'
require_relative 'node'

class BSTTest < Minitest::Test
  def setup
    @tree = BST.new
  end

  def test_can_create_new_tree
    skip
    assert_kind_of BST, @tree
  end

  def test_can_create_new_node
    skip
    node = Node.new
    assert_kind_of Node, node
  end

  def test_can_create_new_node_with_arguments
    skip
    node = Node.new("Simpsons", 100)
    assert_equal "Simpsons", node.data[0]
    assert_equal 100, node.data[1]
  end

  def test_is_there_a_root
    skip
    assert_kind_of Array, @tree.root?
  end

  def test_node_has_data
    skip
    assert_kind_of String, @root.data[0]
    assert_kind_of Fixnum, @root.data[1]
  end

  def test_can_find_node_in_tree
    skip
    assert @tree.include?(@root.data[1])
  end

  def test_can_insert_node_in_tree
    require 'pry'
    binding.pry
    @tree.insert("The Godfather", 75)
    assert_equal true, @tree.include?(75)
  end

end
