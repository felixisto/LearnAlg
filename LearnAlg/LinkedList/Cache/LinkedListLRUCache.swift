//
//  LinkedListLRUCache.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.07.21.
//

import Foundation

/*
 * A cache of items.
 * Discards the least recently used items first. This algorithm requires keeping track of what was used when,
 * which is expensive if one wants to make sure the algorithm always discards the least recently used item.
 * General implementations of this technique require keeping "age bits" for cache-lines and track the
 * "Least Recently Used" cache-line based on age-bits. In such an implementation, every time a cache-line is used,
 * the age of all other cache-lines changes.
 *
 * Having duplicate keys is not possible.
 * O(1) access, insertion and removal.
 */
class LinkedListLRUCache: CustomStringConvertible {
    class Node: CustomStringConvertible {
        var description: String {
            "\(key)=\(value)"
        }
        
        let key: Int
        var value: Int

        var previous: Node?
        var next: Node?

        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    // Ordered from least used to most used
    var description: String {
        var result = "["
        
        var isFirst = true
        
        var node: Node? = tail.previous
        
        while let n = node, n !== head {
            if isFirst {
                isFirst = false
                result += "\(n)"
            } else {
                result += ", \(n)"
            }
            
            node = n.previous
        }
        
        result += "]"
        return result
    }
    
    // When number of stored values exceed this, the oldest used value is evicted.
    private let capacity: Int
    
    private var count : Int = 0

    // Linked list used to tell which data was used latest.
    private let head = Node(0, 0) // most used
    private let tail = Node(0, 0) // least used

    // Dictionary used to read and store values at constant time.
    private var dict = [Int: Node]()

    init(_ capacity: Int) {
        self.capacity = capacity

        head.next = tail
        tail.previous = head
    }
    
    func get(_ key: Int) -> Int? {
        if let node = dict[key] {
            // Since we are using the data, move it to the end, to signal that it has been used lately.
            moveNodeToFront(node)
            return node.value
        }
        
        return nil
    }
    
    func put(_ key: Int, _ value: Int) {
        // Already exists?
        if let node = dict[key] {
            node.value = value
            remove(key)
            insert(node)
            return
        }

        let node = Node(key, value)
        
        dict[key] = node
        
        if count == capacity, let tailKey = tail.previous?.key {
            remove(tailKey)
        }
        
        insert(node)
    }
    
    private func moveNodeToFront(_ node: Node) {
        remove(node.key)
        insert(node)
    }

    private func insert(_ node: Node) {
        dict[node.key] = node

        // Insert new node between dummy head and actual head node:
        node.next = head.next // actual head node
        node.previous = head // dummy
        head.next?.previous = node
        head.next = node // dummy next refers to actual head
        
        count += 1
    }

    private func remove(_ key: Int) {
        guard count > 0, let node = dict[key] else {
            return
        }
        
        dict[key] = nil

        node.previous?.next = node.next
        node.next?.previous = node.previous
        node.previous = nil
        node.next = nil
        
        count -= 1
    }
}
