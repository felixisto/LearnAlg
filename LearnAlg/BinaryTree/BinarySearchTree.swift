//
//  BinarySearchTree.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 3.06.21.
//

import Foundation

// A sorted binary tree.
// Height of the tree is defined as the distance of the root node to the lowest node.
// Duplicate values are allowed.
// Search time complexity: O(h) where h is the height
// Insertion time complexity: O(1)
// Deletion time complexity: O(h)
class BinarySearchTree: BinarySearchTreeNode {
    var root: BinarySearchTreeNode {
        return self
    }
    
    var allValues: [Int] {
        return accumulateAll(order: .inOrder)
    }
    
    override var height: Int {
        return 1 + super.height
    }
    
    override var count: Int {
        return accumulateAll(order: .inOrder).count
    }
}
