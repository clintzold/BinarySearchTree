
class Node
  attr_accessor :left_child, :right_child, :data

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

end
