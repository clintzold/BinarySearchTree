
class Node
  attr_accessor :left, :right, :data

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left = left_child
    @right = right_child
  end

end
