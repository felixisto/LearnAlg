//
//  BinarySearchTreeNode.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 23.06.21.
//

import Foundation

// Mutable value.
class BinarySearchTreeNode: BinaryTreeNode {
    
}

// MARK: Mutation
extension BinarySearchTreeNode {
    // Average time complexity: O(h)
    // Worst time complexity: O(n)
    @discardableResult
    func insert(value: Int) -> BinaryTreeNode? {
        func insert(into parent: BinaryTreeNode) -> BinaryTreeNode {
            if value < parent.value {
                if let left = parent.left {
                    return insert(into: left)
                } else {
                    return parent.makeLeftChild(withValue: value)
                }
            } else {
                if let right = parent.right {
                    return insert(into: right)
                } else {
                    return parent.makeRightChild(withValue: value)
                }
            }
        }
        
        return insert(into: self)
    }
    
    @discardableResult
    func _insertNonRecursive(value: Int) -> BinaryTreeNode? {
        var toDo = 0
        
        func insert(into parent: BinaryTreeNode) -> BinaryTreeNode {
            if value < parent.value {
                if let left = parent.left {
                    return insert(into: left)
                } else {
                    return parent.makeLeftChild(withValue: value)
                }
            } else {
                if let right = parent.right {
                    return insert(into: right)
                } else {
                    return parent.makeRightChild(withValue: value)
                }
            }
        }
        
        return insert(into: self)
    }
    
    func delete(value: Int) {
        func find(node: BinaryTreeNode) {
            if node.value == value {
                node.remove()
                return
            }
            
            if value < node.value {
                if let left = node.left {
                    find(node: left)
                }
            } else {
                if let right = node.right {
                    find(node: right)
                }
            }
        }
        
        find(node: self)
    }
}
