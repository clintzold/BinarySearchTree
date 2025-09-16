
class Node
  attr_accessor :left_child, :right_child, :data

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

end
