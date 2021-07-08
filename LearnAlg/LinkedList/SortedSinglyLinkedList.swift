//
//  SortedSinglyLinkedList.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

struct SortedSinglyLinkedList <T>: LinkedList where T : Numeric, T : Comparable, T : Hashable {
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
    
    init(otherList list: SortedSinglyLinkedList<T>) {
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
    
    func copy() -> SortedSinglyLinkedList {
        return SortedSinglyLinkedList(otherList: self)
    }
    
    mutating func append(_ value: T) {
        let newNode = makeNode(with: value)
        
        if self.first == nil {
            self.first = newNode
            self.last = newNode
            return
        }
        
        var next = self.first
        var last: Node?
        
        while next != nil {
            if let next = next {
                if value < next.value {
                    break
                }
            }
            
            last = next
            next = next?.next
        }
        
        if last == nil {
            // Insert first
            newNode.next = self.first
            self.first = newNode
        } else {
            // Insert after first
            last?.next = newNode
            newNode.next = next
        }
        
        if newNode.next == nil {
            self.last = newNode
        }
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
        
    }
    
    mutating func removeDuplicates() {
        var current: Node? = self.first
        
        while let currentNode = current, let next = currentNode.next {
            if currentNode.value == next.value {
                currentNode.next = next.next
                
                if currentNode.next == nil {
                    self.last = current
                }
            } else {
                current = currentNode.next
            }
        }
    }
    
    mutating func merge(with otherNode: Node) {
        var firstA = self.first
        var firstB: Node? = otherNode
        
        let dummy = Node(value: otherNode.value, next: nil) // Value is not important
        var tail: Node? = dummy
        
        while true {
            guard let a = firstA else {
                tail?.next = firstB
                break
            }
            
            guard let b = firstB else {
                tail?.next = firstA
                break
            }
            
            if a.value <= b.value {
                let newNode = a
                firstA = firstA?.next
                
                newNode.next = tail?.next
                tail?.next = newNode
            } else {
                let newNode = b
                firstB = firstB?.next
                
                newNode.next = tail?.next
                tail?.next = newNode
            }
            
            tail = tail?.next
        }
        
        self.first = dummy.next
        
        // Update last node
        var currentNode = self.first
        
        while true {
            if currentNode?.next == nil {
                self.last = currentNode
                break
            } else {
                currentNode = currentNode?.next
            }
        }
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

// MARK: Helpers
extension SortedSinglyLinkedList {
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
