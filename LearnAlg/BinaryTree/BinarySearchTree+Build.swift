//
//  BinarySearchTree+Build.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 6.06.21.
//

import Foundation

extension BinarySearchTree {
    // Builds balanced tree from the given unordered array.
    convenience init(from data: [Int]) {
        let sorted = data.sorted()
        
        func parse(parent: BinaryTreeNode?, low: Int, high: Int) -> BinaryTreeNode? {
            if low > high {
                return nil
            }
            
            let mid = (high + low) / 2
            
            let node = BinarySearchTreeNode(parent: parent, value: sorted[mid])
            node.left = parse(parent: node, low: low, high: mid - 1)
            node.right = parse(parent: node, low: mid + 1, high: high)
            
            return node
        }
        
        let root = parse(parent: nil, low: 0, high: sorted.count - 1) ?? BinarySearchTreeNode(value: 0)
        
        self.init(value: root.value, left: root.left, right: root.right)
    }
}
