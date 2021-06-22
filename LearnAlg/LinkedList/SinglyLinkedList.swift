//
//  LinkedList.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.06.21.
//

import Foundation

struct SinglyLinkedList <T>: Sequence, CustomStringConvertible {
    class Node <T> {
        var value: T
        var next: Node<T>?
        
        init(value: T, next: Node<T>?) {
            self.value = value
            self.next = next
        }
    }
    
    class Iterator: IteratorProtocol {
        typealias Element = T
        
        var node: Node<T>?
        
        init(_ node: Node<T>?) {
            self.node = node
        }
        
        func next() -> T? {
            let current = self.node
            self.node = self.node?.next
            return current?.value
        }
    }
    
    var description: String {
        var result = "["
        
        var isFirst = true
        
        for node in self {
            if isFirst {
                isFirst = false
                result += "\(node)"
            } else {
                result += ", \(node)"
            }
        }
        
        result += "]"
        return result
    }
    
    private(set) var first: Node<T>?
    private(set) var last: Node<T>?
    
    init() {
        
    }
    
    init(first: T) {
        self.first = makeNode(with: first)
        self.last = self.first
    }
    
    init(otherList list: SinglyLinkedList<T>) {
        for el in list {
            let newNode = makeNode(with: el)
            
            if self.first == nil {
                self.first = newNode
            } else {
                self.last?.next = newNode
            }
            
            self.last = newNode
        }
    }
    
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
    
    @discardableResult
    mutating func delete(at index: Int) -> T {
        if index == 0, let first = self.first {
            let firstValue = first.value
            
            if self.first === self.last {
                self.last = nil
            }
            
            self.first = self.first?.next
            
            return firstValue
        } else {
            let n = node(at: index-1)
            
            if let nodeToBeRemoved = n.next {
                let nValue = nodeToBeRemoved.value
                
                if nodeToBeRemoved === self.last {
                    self.last = nil
                }
                
                let newNext = nodeToBeRemoved.next
                
                n.next = newNext
                
                return nValue
            }
        }
        
        fatalError("Out of bounds")
    }
    
    func copy() -> SinglyLinkedList {
        return SinglyLinkedList(otherList: self)
    }
    
    func makeIterator() -> Iterator {
        return Iterator(first)
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
