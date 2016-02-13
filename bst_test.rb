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

  def test_node_has_data
    assert_kind_of String, @root.data[0]
    assert_kind_of Fixnum, @root.data[1]
  end

  def test_can_find_node_in_tree
    assert @tree.include?(85)
  end

  def test_can_insert_node_in_tree
    assert @tree.include?(100)
    assert_equal true, @tree.include?(30)
    assert_equal true, @tree.include?(82)
    assert_equal true, @tree.include?(0)
  end

  def test_insert_adds_first_node_at_index_0
    new_tree = BST.new
    result_of_insert = new_tree.insert("Bill & Ted's Excellent Adventure", 61)
    assert_equal 0, result_of_insert
  end

  def test_insert_adds_nodes_based_on_value_of_parent
    new_tree = BST.new
    first_value = 61
    second_value = 16
    new_tree.insert("Bill & Ted's Excellent Adventure", first_value)
    result_of_insert = new_tree.insert("Johnny English", second_value)
    assert_equal 1, result_of_insert
  end

  def test_insert_adds_nodes_based_on_value_of_parent_regardless_or_number_or_nodes_inserted
    new_tree = BST.new
    root_value = 61
    greater_than_root_value = 91
    value_less_than_root = 50
    new_tree.insert("Bill & Ted's Excellent Adventure", root_value)
    new_tree.insert("Johnny English", greater_than_root_value, )
    result_of_insert = new_tree.insert("Hannibal Buress: Animal Furnace", value_less_than_root)
    assert_equal 1, result_of_insert
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
    new_tree = BST.new
    assert_equal 100, new_tree.load("movies.txt")
  end

  def test_can_find_leaves
    tree = BST.new
    tree.insert("root", 50)
    tree.insert("lchild", 25)
    tree.insert("rchild", 100)

    assert_equal 2, tree.leaves

    large_tree = BST.new
    large_tree.load("movies.txt")
    assert_equal 36, large_tree.leaves
  end

  def test_can_find_height
    assert_equal 5, @tree.height

    large_tree = BST.new
    large_tree.load("movies.txt")
    assert_equal 13, large_tree.height

    empty_tree = BST.new
    assert_equal nil, empty_tree.height

    root_tree = BST.new
    root_tree.insert("root", 0)
    assert_equal 0, root_tree.height
  end

  def test_return_health_stats
    tree = BST.new
    tree.insert("root", 500)

    assert_equal [[500, 1, 100]], tree.health(0)

    tree2 = BST.new
    tree2.insert("level1", 1000)
    tree2.insert("level1", 250)
    tree2.insert("level2", 200)
    tree2.insert("level2", 1100)
    assert_equal [[250, 2, 50], [1100, 1, 25]], tree2.health(1)

    tree3 = BST.new
    tree3.insert("Animals United", 98)
    tree3.insert("Armageddon", 58)
    tree3.insert("Bill & Ted's Bogus Journey", 36)
    tree3.insert("Bill & Ted's Excellent Adventure", 93)
    tree3.insert("Charlie's Angels", 86)
    tree3.insert("Charlie's Country", 38)
    tree3.insert("Collateral Damage", 69)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree3.health(2)
  end

  def test_integration
    tree = BST.new
    tree.insert("A Faster Horse", 76)
    tree.insert("Animals United", 98)
    assert_equal ["A Faster Horse", 76], tree.root.data
    assert_equal true, tree.include?(98)

    tree.load("movies.txt")
    assert_equal tree.insert("New Test Movie", 101), tree.depth_of(101)

    assert_equal 36, tree.leaves
    assert_equal 14, tree.height

    assert_equal [[17, 71, 70], [75, 4, 3], [80, 20, 19], [99, 3, 2]], tree.health(2)

    hash = {}
    hash["Cruel Intentions"] = 0
    assert_equal hash, tree.min

    hash2 = {}
    hash2["New Test Movie"] = 101
    assert_equal hash2, tree.max

    assert_equal 9, tree.depth_of(62)
  end


end
