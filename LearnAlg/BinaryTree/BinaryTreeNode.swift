//
//  BinaryTreeNode.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 6.06.21.
//

import Foundation

protocol BinaryTreeNode: AnyObject, CustomStringConvertible {
    var value: Int { get }
    
    var parent: BinaryTreeNode? { get set }
    var left: BinaryTreeNode? { get set }
    var right: BinaryTreeNode? { get set }
    
    var isLeaf: Bool { get }
    var hasTwoChildren: Bool { get }
    var isLeftChild: Bool { get }
    var isRightChild: Bool { get }
    
    var height: Int { get }
    var count: Int { get }
    
    var anyChild: BinaryTreeNode? { get }
    var minNode: BinaryTreeNode { get }
    var maxNode: BinaryTreeNode { get }
    
    // MARK: Hierarchy
    
    @discardableResult
    func makeLeftChild(withValue value: Int) -> BinaryTreeNode
    
    @discardableResult
    func makeRightChild(withValue value: Int) -> BinaryTreeNode
    
    // Properly removes the node from its parent.
    func remove()
    
    // MARK: Query
    
    func contains(value: Int) -> Bool
    func findNode(with value: Int) -> BinaryTreeNode?
    func accumulateAll() -> [Int]
    
    // MARK: Mutate
    
    @discardableResult
    func insert(value: Int) -> BinaryTreeNode?
    func delete(value: Int)
}

// MARK: Properties
extension BinaryTreeNode {
    var description: String {
        var s = ""
        
        if let left = self.left {
            s += "(\(left.description)) <- "
        }
        
        s += "\(self.value)"
        
        if let right = self.right {
            s += " -> (\(right.description))"
        }
        
        return s
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    var hasTwoChildren: Bool {
        return left != nil && right != nil
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    var height: Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height ?? 0, right?.height ?? 0)
        }
    }
    
    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    var anyChild: BinaryTreeNode? {
        return left ?? right
    }
}

// MARK: Query
extension BinaryTreeNode {
    func contains(value: Int) -> Bool {
        return findNode(with: value) != nil
    }
    
    func findNode(with value: Int) -> BinaryTreeNode? {
        func find(node: BinaryTreeNode) -> BinaryTreeNode? {
            if node.value == value {
                return node
            }
            
            if value < node.value {
                if let left = node.left {
                    return find(node: left)
                }
            } else {
                if let right = node.right {
                    return find(node: right)
                }
            }
            
            return nil
        }
        
        return find(node: self)
    }
    
    func accumulateAll() -> [Int] {
        var values: [Int] = []
        
        func postOrderTraversal(node: BinaryTreeNode?) {
            guard let node = node else { return }
            postOrderTraversal(node: node.left)
            postOrderTraversal(node: node.right)
            values.append(node.value)
        }
        
        postOrderTraversal(node: self)
        
        return values
    }
}

// MARK: Mutation
extension BinaryTreeNode {
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

// Mutable value.
class BinarySearchTreeNode: BinaryTreeNode {
    var value: Int
    
    weak var parent: BinaryTreeNode?
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    // The given tree node is assumed to be ordered.
    init(parent: BinaryTreeNode?=nil, value: Int) {
        self.parent = parent
        self.value = value
    }
    
    // The given tree node is assumed to be ordered.
    init(value: Int, left: BinaryTreeNode?, right: BinaryTreeNode?) {
        self.parent = nil
        self.value = value
        self.left = left
        self.right = right
    }
    
    // Finds the node with the smallest value starting from the given node.
    var minNode: BinaryTreeNode {
        var node: BinaryTreeNode = self
        
        while case let next? = node.left {
            node = next
        }
        
        return node
    }
    
    // Finds the node with the largest value starting from the given node.
    var maxNode: BinaryTreeNode {
        var node: BinaryTreeNode = self
        
        while case let next? = node.right {
            node = next
        }
        
        return node
    }
    
    // MARK: Hierarchy
    
    @discardableResult
    func makeLeftChild(withValue value: Int) -> BinaryTreeNode {
        let node = BinarySearchTreeNode(parent: self, value: value)
        self.left = node
        return node
    }
    
    @discardableResult
    func makeRightChild(withValue value: Int) -> BinaryTreeNode {
        let node = BinarySearchTreeNode(parent: self, value: value)
        self.right = node
        return node
    }
    
    // Properly removes the node from its parent.
    func remove() {
        if let right = self.right, self.left != nil {
            let successor = right.minNode
            let successorValue = successor.value
            
            // Recursively remove
            successor.remove()
            
            self.value = successorValue
        } else if !self.isLeaf {
            // Replace self with only child
            if let child = self.left ?? self.right {
                if isLeftChild {
                    self.parent?.left = child
                } else {
                    self.parent?.right = child
                }
                
                self.value = child.value
            }
            
            self.left = nil
            self.right = nil
        } else {
            // Removing a leaf? Just update the parent
            if isLeftChild {
                self.parent?.left = nil
            } else {
                self.parent?.right = nil
            }
            
            self.parent = nil
        }
    }
}

// Immutable value.
// Implementation is nearly identical to the mutable one. remove() is significantly different.
class ImmutableBinarySearchTreeNode: BinaryTreeNode {
    let value: Int
    
    weak var parent: BinaryTreeNode?
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    // The given tree node is assumed to be ordered.
    init(parent: BinaryTreeNode?=nil, value: Int) {
        self.parent = parent
        self.value = value
    }
    
    // Finds the node with the smallest value starting from the given node.
    var minNode: BinaryTreeNode {
        var node: BinaryTreeNode = self
        
        while case let next? = node.left {
            node = next
        }
        
        return node
    }
    
    // Finds the node with the largest value starting from the given node.
    var maxNode: BinaryTreeNode {
        var node: BinaryTreeNode = self
        
        while case let next? = node.right {
            node = next
        }
        
        return node
    }
    
    // MARK: Hierarchy
    
    @discardableResult
    func makeLeftChild(withValue value: Int) -> BinaryTreeNode {
        let node = BinarySearchTreeNode(parent: self, value: value)
        self.left = node
        return node
    }
    
    @discardableResult
    func makeRightChild(withValue value: Int) -> BinaryTreeNode {
        let node = BinarySearchTreeNode(parent: self, value: value)
        self.right = node
        return node
    }
    
    // Properly removes the node from its parent.
    // This node instance should be discarded after this operation.
    func remove() {
        let successor: BinaryTreeNode?
        
        if let left = self.left {
            if let right = self.right {
                successor = removeWithTwoChildren(left: left, right: right)
            } else {
                successor = left
            }
        } else if let right = self.right {
            successor = right
        } else {
            successor = nil
        }
        
        replaceSelf(with: successor)
    }
    
    private func removeWithTwoChildren(left originalLeft: BinaryTreeNode,
                                       right originalRight: BinaryTreeNode) -> BinaryTreeNode {
        let successor = originalRight.minNode
        
        // Recursively remove
        successor.remove()
        
        // Begin replacement
        // The successor will copy the children of the node being replaced
        successor.left = originalLeft
        originalLeft.parent = successor
        
        // Update successor right
        if originalRight !== successor {
            successor.right = originalRight
            originalRight.parent = successor
        } else {
            // In this case, the successor is simply the right child
            // Nullify the future right child, otherwise a circular reference will be created
            successor.right = nil
        }
        
        return successor
    }
    
    private func replaceSelf(with replacement: BinaryTreeNode?) {
        if let parent = self.parent {
            if isLeftChild {
                parent.left = replacement
            } else {
                parent.right = replacement
            }
            
            replacement?.parent = parent
        }
        
        self.parent = nil
        self.left = nil
        self.right = nil
    }
}
