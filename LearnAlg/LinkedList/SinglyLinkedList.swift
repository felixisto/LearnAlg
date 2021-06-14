//
//  LinkedList.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.06.21.
//

import Foundation

struct SinglyLinkedList <T> {
    class Node <T> {
        var value: T
        var next: Node<T>?
        
        init(value: T, next: Node<T>?) {
            self.value = value
            self.next = next
        }
    }
    
    private(set) var first: Node<T>?
    private(set) var last: Node<T>?
    
    subscript(_ index: Int) -> T {
        return node(at: index).value
    }
    
    mutating func append(_ value: T) {
        if self.first == nil {
            self.first = makeNode(with: value)
            self.last = self.first
        } else {
            let next = makeNode(with: value)
            self.last?.next = next
            self.last = next
        }
    }
    
    mutating func insert(_ value: T, at index: Int) {
        let newNode = makeNode(with: value)
        
        if index == 0 {
            newNode.next = self.first
            self.first = newNode
        } else {
            let prev = node(at: index-1)
            newNode.next = prev.next
            prev.next = newNode
        }
        
        self.last = newNode
    }
}

// MARK: Helpers
extension SinglyLinkedList {
    private func node(at index: Int) -> Node<T> {
        if index == 0, let first = self.first {
            return first
        }
        
        if index <= 0 {
            fatalError("Out of bounds")
        }
        
        var node: Node<T>? = self.first
        
        for _ in 1...index {
            node = node?.next
        }
        
        if let node = node {
            return node
        }
        
        fatalError("Out of bounds")
    }
    
    private func makeNode(with value: T) -> Node<T> {
        return Node<T>(value: value, next: nil)
    }
}
