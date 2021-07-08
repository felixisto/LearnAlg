//
//  LinkedList.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

protocol LinkedList: Sequence, CustomStringConvertible {
    associatedtype T where T : Comparable, T : Hashable
    
    var first: LinkedListNode<T>? { get }
    var last: LinkedListNode<T>? { get }
    
    subscript(_ index: Int) -> T { get }
    
    func copy() -> Self
    
    mutating func append(_ value: T)
    
    @discardableResult
    mutating func delete(at index: Int) -> T
    mutating func deleteFirst(condition: (Int, T)->Bool)
    mutating func deleteAll(condition: (Int, T)->Bool)
    
    mutating func sort()
    mutating func removeDuplicates()
    
    mutating func merge(with otherNode: LinkedListNode<T>)
}

class LinkedListNode <T> : CustomStringConvertible, Hashable where T : Comparable {
    var description: String {
        if let next = next {
            return "<\(value) -> \(next.value)>"
        } else {
            return "<\(value) -> nil>"
        }
    }
    
    var value: T
    var next: LinkedListNode<T>?
    
    init(value: T, next: LinkedListNode<T>?) {
        self.value = value
        self.next = next
    }
    
    static func == (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

class LinkedListIterator <T>: IteratorProtocol where T : Comparable {
    typealias Element = T
    
    var node: LinkedListNode<T>?
    
    init(_ node: LinkedListNode<T>?) {
        self.node = node
    }
    
    func next() -> T? {
        let current = self.node
        self.node = self.node?.next
        return current?.value
    }
}

extension LinkedList {
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
    
    mutating func deleteFirst(condition: (Int, T)->Bool) {
        var index = 0
        
        for node in copy() {
            if condition(index, node as! Self.T) {
                delete(at: index)
                break
            }
            
            index += 1
        }
    }
    
    mutating func deleteAll(condition: (Int, T)->Bool) {
        var index = 0
        
        for node in copy() {
            if condition(index, node as! Self.T) {
                delete(at: index)
            } else {
                index += 1
            }
        }
    }
}

extension LinkedListNode {
    // ZOMG! Floyd’s Cycle Detection Algorithm!!1!
    // Time complexity: O(n)
    // Space complexity: O(1)
    func findFirstCycleReference() -> (first: LinkedListNode, last: LinkedListNode)? {
        var slow: LinkedListNode? = self
        var fast: LinkedListNode? = self
        
        while let s = slow, let f = fast {
            slow = s.next
            fast = f.next?.next
            
            // Works with only one node referring to itself
            if s === f {
                return (s, f)
            }
        }
        
        return nil
    }
    
    // Time complexity: O(n)
    // Space complexity: O(n)
    func findFirstCycleReferenceWithHashing() -> (first: LinkedListNode, last: LinkedListNode)? {
        var cache = Set<LinkedListNode>()
        
        var current: LinkedListNode? = self
        var previous: LinkedListNode?
        
        while let node = current {
            if cache.contains(node) {
                return (node, previous!)
            }
            
            cache.insert(node)
            
            previous = current
            current = current?.next
        }
        
        return nil
    }
}
