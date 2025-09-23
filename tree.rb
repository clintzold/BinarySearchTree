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

  #Begins the delete process, calling different methods depending on position of node(two children, one child, or no child)
  def delete(root = @root, value)
    #Base case(match not found)
    return root if root.nil?
    
    #Traverses tree to find matching value
    if root.data > value
      root.left = delete(root.left, value)
    elsif root.data < value
      root.right = delete(root.right, value)
    else
      #Match where root has 0 children or only right child
      if root.left.nil?
        return root.right
      #Match where root has only left child
      elsif root.right.nil?
        return root.left
      else
        #Match when root has left and right children
        successor = find_successor(root.right)
        root.data = successor.data
        root.right = delete(root.right, successor.data)
      end
    end
    return root
  end


  def find(root = @root, value)
    #Returns root(nil) if no matches found
    return root if root.nil?
    #Traverses tree, left or right looking for a match
    if root.data > value
      find(root.left, value)
    elsif root.data < value
      find(root.right, value)
    #Returns node when value matches node data
    else
      return root
    end
  end

  #Iterative level order traversal(yields each node to optional block)
  def level_order(root = @root)
    return [] if root.nil?
    result = []
    queue = [root]

    while !queue.empty?
      level_size = queue.length
      current_level_values = []
      level_size.times do 
        node = queue.shift
        current_level_values << node.data

        queue << node.left if node.left
        queue << node.right if node.right

        yield node if block_given?
      end
      result << current_level_values
    end
    return result if !block_given?
  end

  #Recursive level order traversal(yields each node to optional block)
  def level_order_recur(root = @root, &block)
    result = []
    level_order_helper(root, 0, result, &block)
    #Does not return array of values if block has been passed
    return if block_given?
    #Returns array of values in order of traversal
    return result
  end
  #Creates an array for each level of BST
  def level_order_helper(node, level, result, &block)
    return if node.nil?
    if level == result.length
      result << []
    end
    result[level] << node.data
    level_order_helper(node.left, level + 1, result, &block)
    level_order_helper(node.right, level + 1, result, &block)

    #Node is yielded to block if given
    block.call(node) if block_given?
  end


  #Recursively traverses tree depth-first and in order(left, root, right) and yields nodes to block. Returns array if block is not given
  def inorder(root = @root, &block)
    result = []
    inorder_helper(root, result, &block)
    return if block_given?
    return result
  end

  def inorder_helper(root, result, &block)
    return if root.nil?
    inorder_helper(root.left, result, &block)
    block.call(root) if block_given?
    result << root.data
    inorder_helper(root.right, result, &block)
  end


  #Recursively traverses tree depth-first in preorder(Root, Left, Right)
  def preorder(root = @root, &block)
    result = []
    preorder_helper(root, result, &block)
    return if block_given?
    return result
  end

  def preorder_helper(root, result, &block)
    return if root.nil?
    block.call(root) if block_given?
    result << root.data
    preorder_helper(root.left, result, &block)
    preorder_helper(root.right, result, &block)
  end


  #Recursively traverses tree depth-first in postorder(Left, Right, Root)
  def postorder(root= @root, &block)
    result = []
    postorder_helper(root, result, &block)
    return if block_given?
    return result
  end

  def postorder_helper(root, result, &block)
    return if root.nil?
    postorder_helper(root.left, result, &block)
    postorder_helper(root.right, result, &block)
    block.call(root) if block_given?
    result << root.data
  end

  #Measures the height of node specified by value(perhaps should have used recursion)
  def height(value)
    node = find(value)
    #Returns nil if node does not exists
    return if node.nil?
    #Variables to measure height by iteration
    height_left = node
    height_right = node
    left = 0
    right = 0
    #Finds height of left path
    while height_left.left
      left += 1
      height_left = height_left.left
    end
    #Finds height of right path
    while height_right.right
      right += 1
      height_right = height_right.right
    end
    #Compares left and right height and returns the greatest number
    if left > right
      return left
    else
      return right
    end
  end

  #Measures depth of node from root
  def depth(value, root = @root, depth = 0)
    return if root.nil?
      if root.data > value
        depth += 1
        depth(value, root.left, depth)
      elsif root.data < value
        depth += 1
        depth(value, root.right, depth)
      else 
        return depth
      end
  end

  #Finds minimum value in subtree
  def find_successor(root)
    return root if root.left.nil?
    successor = root.left
    return successor if successor.left.nil?
    find_successor(successor)
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
