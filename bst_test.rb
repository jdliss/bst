gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'binary_search_tree'
require_relative 'node'
require 'pry'

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
    hash = {}
    hash["Pulp Fiction"] = 200
    assert_equal hash, @tree.max
  end

  def test_can_find_min
    hash = {}
    hash["Goonies"] = 0
    assert_equal hash, @tree.min
  end

  def test_can_sort
    sorted = [
      {"Goonies"=>0},
      {"Goosebumps"=>1},
      {"Scary Movie"=>30},
      {"The Godfather"=>75},
      {"Lord of the Rings"=>80},
      {"Lord of the Rings 2"=>82},
      {"Saving Private Ryan"=>85},
      {"Star Wars"=>90},
      {"The Simpsons Movie"=>100},
      {"Pulp Fiction"=>200}
    ]
    assert_equal sorted, @tree.sort
  end

  def test_can_build_new_tree_from_file
    new_tree = BST.new.load("movies.txt")
  end

  def test_can_find_leaves
    tree = BST.new
    tree.insert("root", 50)
    tree.insert("lchild", 25)
    tree.insert("rchild", 100)

    assert_equal 2, tree.leaves

    large_tree = BST.new
    large_tree.load("movies.txt")
    assert_equal 35, large_tree.leaves
  end
end
