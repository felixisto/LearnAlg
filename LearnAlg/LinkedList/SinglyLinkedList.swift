//
//  LinkedList.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.06.21.
//

import Foundation

struct SinglyLinkedList <T>: LinkedList where T : Comparable, T : Hashable {
    typealias Node = LinkedListNode<T>
    typealias Iterator = LinkedListIterator<T>
    
    private(set) var first: Node?
    private(set) var last: Node?
    
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
    
    func copy() -> SinglyLinkedList {
        return SinglyLinkedList(otherList: self)
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
    
    mutating func sort() {
        guard let first = self.first else {
            return
        }
        
        let dummyNode = Node(value: first.value, next: nil) // Value is not important
        
        var last = dummyNode
        var current: Node? = first
        var next : Node? = nil
        
        while let currentNode = current {
            next = currentNode.next
            
            // Find proper place
            while let lastNext = last.next, lastNext.value < currentNode.value {
                last = lastNext
            }
            
            // Insert between last and last.next
            currentNode.next = last.next
            last.next = currentNode
            
            if currentNode.next == nil {
                self.last = currentNode
            }
            
            // Next step
            current = next
            last = dummyNode
        }
        
        self.first = dummyNode.next
    }
    
    mutating func removeDuplicates() {
        var last: Node?
        var current: Node? = self.first
        
        var cache = Set<T>()
        
        while let currentNode = current {
            if cache.contains(currentNode.value) {
                // Already seen, skip!
                last?.next = currentNode.next
                
                if last?.next == nil {
                    self.last = last
                }
            } else {
                cache.insert(currentNode.value)
                last = currentNode
            }
            
            current = currentNode.next
        }
    }
    
    mutating func merge(with list: SinglyLinkedList) {
        
    }
    
    func makeIterator() -> Iterator {
        return Iterator(first)
    }
}

// MARK: Helpers
extension SinglyLinkedList {
    private func node(at index: Int) -> Node {
        if index == 0, let first = self.first {
            return first
        }
        
        if index <= 0 {
            fatalError("Out of bounds")
        }
        
        var node: Node? = self.first
        
        for _ in 1...index {
            node = node?.next
        }
        
        if let node = node {
            return node
        }
        
        fatalError("Out of bounds")
    }
    
    private func makeNode(with value: T) -> Node {
        return Node(value: value, next: nil)
    }
}
