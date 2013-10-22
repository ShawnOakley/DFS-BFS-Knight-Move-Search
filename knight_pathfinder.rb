require './TreeNode'

class KnightPathFinder

  attr_reader :starting_node

  def initialize (starting_position = [0,0])
    @starting_node = TreeNode.new(starting_position)
  end

  def run(target)
    self.find_path(target).each do |node|
      p node.value
    end
  end

  def possible_moves(current_coordinate)
    KnightPathFinder.move_space.map do |move|
      [move[0] + current_coordinate[0], move[1] + current_coordinate[1]]
    end
  end

  def self.calculate_move_space(vector_1, vector_2)
    vector_1.product(vector_2) + vector_2.product(vector_1)
  end

  def self.move_space
    KnightPathFinder.calculate_move_space([1, -1], [2, -2])
  end

  def build_tree(tree_levels = 4)
    previous_moves = [starting_node.value]
    child_moves = create_child_moves(starting_node, previous_moves)
    current_position = child_moves
    previous_moves += child_moves

    tree_levels.times do # or until target is found
      child_moves = current_position.map { |position| create_child_moves(position, previous_moves) }
      child_moves = child_moves.flatten.uniq
      current_position = child_moves
      previous_moves += child_moves
    end
    return true
  end

  # takes a parent node / coordinate, and creates child nodes for all possible moves from that coordinate, removing previously visited coordinates
  def create_child_moves(coordinate_node, previous_moves)
    new_child_values = possible_moves(coordinate_node.value) - previous_moves
    new_child_nodes = TreeNode.generate_nodes(new_child_values)
    new_child_nodes.each { |node| coordinate_node.add_child(node) }
    new_child_nodes
  end

  def find_path(target_pos)
    build_tree
    target = self.starting_node.bfs(target_pos)
    (target.path(starting_node.value) + [starting_node]).reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  KnightPathFinder.new.run([5,0])
end