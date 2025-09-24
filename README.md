Binary Search Tree

A binary search tree class created for The Odin Project

METHODS

    #build_tree(array, start, finish)

        -Takes a sorted array(#merge_sort is included in Tree class) and turns it into
         a binary tree full of Node objects(see Node class)

    #insert(value) and #delete(value)

        - Insert and remove nodes
        - #delete covers all cases from leaf nodes, to single child and two child parent nodes

    #find(value)

        - Takes a value and retrieves a node containing the data
        - Returns nil if value is not found

    #level_order(root)

        - Accepts a block and yields nodes to it in breadth-first order
        - Returns array if no block is passed

    #inorder, #preorder, #postorder *all accept params(root, &block)

        - Accept blocks and yield nodes to block according to traversal order
        - Also returns an array if no block is given

    #height(value), #depth(value)

        - Returns the height or depth of node matching value given
        - Returns nil if no node is found

    #balanced?
    
        - Returns true or false depending on difference in height between subtrees

    #rebalance

        - Restructures unbalanced tree using array from #inorder, passed to #build_tree


        **Several of these methods utilize helper methods to assist in recursion
