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
    
    // After merge, both lists should have identical node structure.
    mutating func merge(with list: Self)
}

class LinkedListNode <T> where T : Comparable {
    var value: T
    var next: LinkedListNode<T>?
    
    init(value: T, next: LinkedListNode<T>?) {
        self.value = value
        self.next = next
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
