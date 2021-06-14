//
//  BinaryTreeNode+Validators.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 6.06.21.
//

import Foundation

extension BinaryTreeNode {
    // Returns true if the node hierarchy is properly ordered to be considered BST.
    // Balanced means the height of the left/right subtrees do not differ by more than 1.
    var isBinarySearchTree: Bool {
        func isBST(node: BinaryTreeNode, min: Int, max: Int) -> Bool {
            if node.value < min || node.value > max {
                return false
            }
            
            if let left = node.left {
                if !isBST(node: left, min: min, max: node.value) {
                    return false
                }
            }
            
            if let right = node.right {
                if !isBST(node: right, min: node.value, max: max) {
                    return false
                }
            }
            
            return true
        }
        
        return isBST(node: self, min: Int.min, max: Int.max)
    }
}
