require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def build_tree(array)



  end

  def merge_sort(array)

    return array if array.length == 1

    left_array = array.slice(0...array.length / 2)
    right_array = array.slice(array.length / 2 ..-1)
    merge(merge_sort(left_array), merge_sort(right_array))
  end

  def merge(left, right)

    sorted = []

    until left.length == 0 || right.length == 0
      sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right

  end
end
