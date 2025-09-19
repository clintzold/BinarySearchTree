require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array, 0, array.length - 1)  #Starts with full array as start and last to return middle of array as root. Sub-trees are later created recursively using each half of the array
  end


  def build_tree(array, start, last)

    return nil if start > last  #If array has no more elements, recursion ends

    middle = start + (last - start) / 2 #Find middle index of array

    root = Node.new(array[middle])  #Create root not from middle element of array 

    root.left = build_tree(array, start, middle - 1)  #Build left sub-tree
    root.right = build_tree(array, middle + 1, last)  #Build right sub-tree

    return root

  end

  #Compares value to node data and inserts left or right if there is no existing child node.
  #If child node exists, recursively compares and iterates until appropriate insertion point is found.
  def insert(value, node = @root)

    if value < node.data && node.left.nil?
      node.left = Node.new(value)
      return node.left
    elsif value > node.data && node.right.nil?
      node.right = Node.new(value)
      return node.right
    elsif value < node.data
      insert(value, node.left)
    elsif value > node.data
      insert(value, node.right)
    else
      return nil
    end

  end
  #Prints tree in an easy to understand format
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


  def self.merge_sort(array)

    return array if array.length == 1

    left_array = array.slice(0...array.length / 2)
    right_array = array.slice(array.length / 2 ..-1)
    merge(merge_sort(left_array), merge_sort(right_array))
  end

  def self.merge(left, right)

    sorted = []

    until left.length == 0 || right.length == 0
      sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right

  end
end
