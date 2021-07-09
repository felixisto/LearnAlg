//
//  HashTable.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 9.07.21.
//

import Foundation

class HashTable {
    struct Buckets <Key, Value> : CustomStringConvertible where Key: Hashable {
        typealias Element = (key: Key, value: Value)
        typealias Bucket = [Element]
        
        private var buckets: [Bucket]
        
        private(set) var count = 0
        
        var numberOfCollisions: Int {
            var result = 0
            
            for bucket in buckets {
                if bucket.count > 1 {
                    result += 1
                }
            }
            
            return result
        }
        
        var description: String {
            var result = "["
            
            var isFirst = true
            
            for bucket in buckets {
                for el in bucket {
                    if isFirst {
                        isFirst = false
                        result += "\(el.key) : \(el.value)"
                    } else {
                        result += "; \(el.key) : \(el.value)"
                    }
                }
            }
            
            result += "]"
            
            return result
        }
        
        var isEmpty: Bool {
            return count == 0
        }

        init(capacity: Int) {
            assert(capacity > 0)
            buckets = Array<Bucket>(repeatElement([], count: capacity))
        }
        
        subscript(_ key: Key) -> Value? {
            get {
                return value(forKey: key)
            }
            set {
                if let value = newValue {
                    insert(value: value, forKey: key)
                } else {
                    removeValue(forKey: key)
                }
            }
        }
        
        func contains(key: Key) -> Bool {
            return value(forKey: key) != nil
        }
        
        func value(forKey key: Key) -> Value? {
            for bucket in buckets[index(forKey: key)] {
                if bucket.key == key {
                    return bucket.value
                }
            }
            
            return nil
        }
        
        mutating func insert(value: Value, forKey key: Key) {
            let index = index(forKey: key)
            
            // Already exists? Just update the entry
            var entryIndex = 0
            
            for entry in self.buckets[index].enumerated() {
                if entry.element.key == key {
                    self.buckets[index][entryIndex].value = value
                    return
                }
                
                entryIndex += 1
            }
            
            // Add new value
            buckets[index].append((key, value))
            
            count += 1
        }
        
        mutating func removeValue(forKey key: Key) {
            let index = index(forKey: key)
            
            var buckets = buckets[index]
            
            buckets.removeAll { entry in
                entry.key == key
            }
            
            self.buckets[index] = buckets
            
            count -= 1
        }
        
        private func index(forKey key: Key) -> Int {
            return abs(key.hashValue % buckets.count)
        }
    }
    
    struct Resizable <Key, Value> : CustomStringConvertible where Key: Hashable {
        typealias Element = (key: Key, value: Value)
        
        private let capacity: Int
        private var data: [Element?]
        
        private(set) var count = 0
        
        var description: String {
            var result = "["
            
            var isFirst = true
            
            for el in data {
                guard let entry = el else {
                    continue
                }
                
                if isFirst {
                    isFirst = false
                    result += "\(entry.key) : \(entry.value)"
                } else {
                    result += "; \(entry.key) : \(entry.value)"
                }
            }
            
            result += "]"
            
            return result
        }
        
        var isEmpty: Bool {
            count == 0
        }
        
        var currentTableSize: Int {
            data.count
        }

        init(initialSize: Int, capacity: Int) {
            assert(capacity > 0)
            self.capacity = capacity
            data = [Element?](repeating: nil, count: initialSize)
        }
        
        subscript(_ key: Key) -> Value? {
            get {
                return value(forKey: key)
            }
            set {
                if let value = newValue {
                    insert(value: value, forKey: key)
                } else {
                    removeValue(forKey: key)
                }
            }
        }
        
        func contains(key: Key) -> Bool {
            return value(forKey: key) != nil
        }
        
        func value(forKey key: Key) -> Value? {
            return data[index(forKey: key)]?.value
        }
        
        mutating func insert(value: Value, forKey key: Key) {
            let index = index(forKey: key)
            
            while true {
                if let entry = data[index] {
                    // Detect collision: index is the same but the keys are different
                    if entry.key != key {
                        increaseSize()
                    } else {
                        break
                    }
                } else {
                    count += 1
                    break
                }
            }
            
            data[index] = (key, value)
        }
        
        mutating func removeValue(forKey key: Key) {
            let index = index(forKey: key)
            
            if data[index] != nil {
                count -= 1
            }
            
            data[index] = nil
        }
        
        private func index(forKey key: Key) -> Int {
            return abs(key.hashValue % data.count)
        }
        
        private mutating func increaseSize() {
            let dataCopy = data
            
            let newSize = currentTableSize * 2
            
            if newSize > capacity {
                fatalError("Cannot resize hash table, capacity \(capacity) reached")
            }
            
            data = [Element?](repeating: nil, count: newSize)
            
            for entry in dataCopy {
                if let entry = entry {
                    insert(value: entry.value, forKey: entry.key)
                }
            }
        }
    }
}
