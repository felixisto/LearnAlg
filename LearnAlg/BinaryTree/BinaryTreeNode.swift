//
//  BinaryTreeNode.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 6.06.21.
//

import Foundation

class BinaryTreeNode: CustomStringConvertible, Hashable {
    var value: Int
    
    weak var parent: BinaryTreeNode?
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
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
    
    // MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
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

enum BinaryTreeNodeTraverseOrder {
    // For Tree
    // ((8) <- 10 -> (12)) <- 15 -> ((18) <- 20 -> (25))
    // we get these values
    case preOrder // [15, 10, 8, 12, 20, 18, 25]
    case inOrder // [8, 10, 12, 15, 18, 20, 25]
    case postOrder // [8, 12, 10, 18, 25, 20, 15]
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
    
    func accumulateAll(order: BinaryTreeNodeTraverseOrder) -> [Int] {
        var values: [Int] = []
        
        func preOrderTraversal(node: BinaryTreeNode?) {
            guard let node = node else { return }
            values.append(node.value)
            preOrderTraversal(node: node.left)
            preOrderTraversal(node: node.right)
        }
        
        func inOrderTraversal(node: BinaryTreeNode?) {
            guard let node = node else { return }
            inOrderTraversal(node: node.left)
            values.append(node.value)
            inOrderTraversal(node: node.right)
        }
        
        func postOrderTraversal(node: BinaryTreeNode?) {
            guard let node = node else { return }
            postOrderTraversal(node: node.left)
            postOrderTraversal(node: node.right)
            values.append(node.value)
        }
        
        switch order {
        case .preOrder:
            preOrderTraversal(node: self)
        case .inOrder:
            inOrderTraversal(node: self)
        case .postOrder:
            postOrderTraversal(node: self)
        }
        
        return values
    }
    
    func _accumulateAll_Iterative(order: BinaryTreeNodeTraverseOrder) -> [Int] {
        var values: [Int] = []
        
        var stack = Stack<BinaryTreeNode>()
        
        func preOrderTraversal() {
            stack.push(self)
            
            while let top = stack.popSafely() {
                values.append(top.value)
                
                if let right = top.right {
                    stack.push(right)
                }
                
                if let left = top.left {
                    stack.push(left)
                }
            }
        }
        
        func inOrderTraversal() {
            var current: BinaryTreeNode? = self
            
            while !stack.isEmpty || current != nil {
                if let c = current {
                    stack.push(c)
                    
                    current = c.left
                } else {
                    current = stack.pop()
                    
                    if let value = current?.value {
                        values.append(value)
                    }
                    
                    current = current?.right
                }
            }
        }
        
        func postOrderTraversal() {
            stack.push(self)
            
            while let top = stack.popSafely() {
                values.append(top.value)
                
                if let left = top.left {
                    stack.push(left)
                }
                
                if let right = top.right {
                    stack.push(right)
                }
            }
            
            values.reverse()
        }
        
        switch order {
        case .preOrder:
            preOrderTraversal()
        case .inOrder:
            inOrderTraversal()
        case .postOrder:
            postOrderTraversal()
        }
        
        return values
    }
}
