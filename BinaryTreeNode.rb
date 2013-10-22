require 'debugger'
#include 'TreeNode.rb'

class BinaryTreeNode #< TreeNode

  attr_accessor :value, :parent
  attr_reader :left, :right

  def test
    node_1 = BinaryTreeNode.new(1)
    node_2 = BinaryTreeNode.new(2)
    node_3 = BinaryTreeNode.new(3)
    node_4 = BinaryTreeNode.new(4)
    node_5 = BinaryTreeNode.new(5)
    node_6 = BinaryTreeNode.new(6)
    node_7 = BinaryTreeNode.new(7)
    node_8 = BinaryTreeNode.new(8)
    node_9 = BinaryTreeNode.new(9)

    node_1.left = node_2
    node_1.right = node_5
    node_2.right = node_3
    node_2.left = node_4
    node_5.left = node_6
    node_5.right = node_7
    node_7.left = node_8
    node_7.right = node_9


    p node_1.bfs(9)
    puts
    p node_1.bfs(9).value
    puts
    p node_1.dfs(9)
    puts
    p node_1.dfs(9).value
  end

  # def dfs(target_value)
  #   #debugger
  #   if self.value == target_value
  #     return self
  #   elsif left.nil? && right.nil?
  #     return nil
  #   elsif left.nil? && !right.nil?
  #     right.dfs(target_value)
  #   elsif !left.nil? && right.nil?
  #     left.dfs(target_value)
  #   elsif !left.nil? && !right.nil?
  #     val = left.dfs(target_value)
  #     if !val.nil?
  #       val
  #     else
  #       right.dfs(target_value)
  #     end
  #   end
  # end

  def dfs(target_value)
    #debugger
    if self.value == target_value
      return self
    elsif !self.has_child?
      return nil
    elsif self.has_child?
      [child_array.first.dfs(target_value), child_array.last.dfs(target_value)].compact.first
    end
  end

  def bfs(target_value)
    current_nodes = [self]
    until current_nodes.empty? || current_nodes.map{|node| node.value }.include?(target_value)
      temp = []
      current_nodes.each do |node|
        temp += node.child_array
      end
      current_nodes = temp
    end
    return current_nodes.select{|node| node.value == target_value}.first
  end

  def initialize(value = nil)
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end

  def left=(new_left_node)
    self.left.parent = nil if self.left != nil
    @left = new_left_node
    new_left_node.parent = self
  end

  def right=(new_right_node)
    self.right.parent = nil if self.right != nil
    @right = new_right_node
    new_right_node.parent = self
  end

  def child_array
    return [self.left, self.right].compact
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
  BinaryTreeNode.new.test
end