require_relative 'node'
require_relative 'tree'

array = Array.new(25) { rand(100) } 
array = array.uniq
array = Tree.merge_sort(array)
tree = Tree.new(array)

tree.pretty_print
