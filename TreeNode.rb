require 'debugger'

class TreeNode

  attr_accessor :value, :parent
  attr_reader :child_array

  def test
    node_1 = TreeNode.new(1)
    node_2 = TreeNode.new(2)
    node_3 = TreeNode.new(3)
    node_4 = TreeNode.new(4)
    node_5 = TreeNode.new(5)
    node_6 = TreeNode.new(6)
    node_7 = TreeNode.new(7)
    node_8 = TreeNode.new(8)
    node_9 = TreeNode.new(9)
    node_10 = TreeNode.new(10)
    node_11 = TreeNode.new(11)
    node_1.add_children(node_2, node_5)
    node_2.add_children(node_3, node_4)
    node_5.add_children(node_6, node_7, node_8)
    node_7.add_children(node_9, node_10, node_11)

    node_10.path(1).each do |node|
      p node.value
    end
    puts
    node_4.path(1).each do |node|
      p node.value
    end
    puts
    node_8.path(1).each do |node|
      p node.value
    end
    puts
    node_11.path(5).each do |node|
      p node.value
    end

  end

  def dfs(target_value = nil, &blk)
    condition_satisfied= block_given? ? blk.call(self.value) : (self.value == target_value)
    if condition_satisfied
      return self
    elsif !self.has_child?
      return nil
    elsif self.has_child?
      if block_given?
        child_array.map{ |node| node.dfs(&blk)}.compact.first
      else
        child_array.map{ |node| node.dfs(target_value)}.compact.first
      end
    end
  end

  def path(origin_value)
    if parent.value == origin_value
      return [self]
    else
      [self] + self.parent.path(origin_value)
    end
  end

  def bfs(target_value = nil, &blk)
    def get_values (current_nodes)
      Hash[current_nodes.map { |node| node.value }.zip(current_nodes)]
    end
    blk = Proc.new{|value| value == target_value} unless block_given?

    current_nodes = [self]
    until current_nodes.empty? || !get_values(current_nodes).keys.select(&blk).empty?
      temp = []
      current_nodes.each do |node|
        temp += node.child_array
      end
      current_nodes = temp
    end
    value_node_hash = get_values(current_nodes)
    value_node_hash[value_node_hash.keys.select(&blk).first]
  end

  # def bfs_no_block(target_value)
  #   def get_values (current_nodes)
  #     current_nodes.map { |node| node.value }
  #   end
  #   current_nodes = [self]
  #   until current_nodes.empty? || !get_values(current_nodes).select{|value| value == target_value}.empty?
  #     temp = []
  #     current_nodes.each do |node|
  #       temp += node.child_array
  #     end
  #     current_nodes = temp
  #   end
  #   current_nodes.select{|node| node.value == target_value }.first
  # end

  def initialize(value = nil)
    @value = value
    @parent = nil
    @child_array = []
  end

  def add_child(child_node)
    self.child_array << child_node
    child_node.parent = self
  end

  def add_children(*children)
    children.each{|child| self.add_child(child)}
  end

  def self.generate_nodes(values)
    values.map{|value| TreeNode.new(value)}
  end

  def has_child?
    return !self.child_array.empty?
  end


  # The Parent Setter
  # -- a helper method for use only within the child node setters
  # -- should be private, probably
  # -- if called on its own, we will have inconsistency in the tree
  # ----- children with parent's that are unaware of their children

  # def set_child(new_child_node, position)
 #    if position == "left"
 #      @left = new_child_node
 #    elsif position == "right"
 #      @right = new_child_node
 #    else
 #      raise "Invalid position"
 #    end
 #  end

end

if __FILE__ == $PROGRAM_NAME
  TreeNode.new.test
end