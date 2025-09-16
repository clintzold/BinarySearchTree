require 'pry-byebug'
require_relative 'comparable'
require_relative 'node'
require_relative 'tree'


array = Array.new(10) { rand(100) }

tree = Tree.new(array)

puts tree.root.data
