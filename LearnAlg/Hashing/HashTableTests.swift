//
//  HashTableTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 9.07.21.
//

import Foundation

class HashTableTests {
    func test() {
        print(#function)
        
        testBuckets()
        testBucketsCollision()
        testResizable()
        testResizableCollision()
    }
    
    func testBuckets() {
        print(#function)
        
        var tableBuckets = HashTable.Buckets<String, String>(capacity: 5)
        
        tableBuckets["firstName"] = "Steve"
        
        // Expected: ["firstName" : "Steve"]
        print("hash table buckets: \(tableBuckets)")
        
        // Expected: "Steve"
        print("hash table value for 'firstName': \(String(describing: tableBuckets.value(forKey: "firstName")))")
        
        print("replace entry 'firstName' value with 'Tim'")
        
        tableBuckets["firstName"] = "Tim"
        
        // Expected: "Tim"
        print("hash table value for 'firstName': \(String(describing: tableBuckets.value(forKey: "firstName")))")
        
        // Expected: ["firstName" : "Tim"]
        print("hash table buckets: \(tableBuckets)")
        
        print("delete entry 'firstName'")
        
        tableBuckets["firstName"] = nil
        
        // Expected: []
        print("hash table buckets: \(tableBuckets)")
        print("hash table buckets number of collisions - \(tableBuckets.numberOfCollisions)")
    }
    
    func testBucketsCollision() {
        print(#function)
        
        var tableBuckets = HashTable.Buckets<String, String>(capacity: 5)
        
        tableBuckets["hobbies"] = "Test"
        tableBuckets["firstName"] = "Check"
        tableBuckets["lastName"] = "mate"
        
        print("adding 3 items, 2 should collide...")
        
        // Expected: ["hobbies" : "Test", "firstName" : "Check", "lastName" : "mate"]
        print("hash table buckets: \(tableBuckets)")
        print("hash table buckets number of collisions - \(tableBuckets.numberOfCollisions)")
    }
    
    func testResizable() {
        print(#function)
        
        var tableResizable = HashTable.Resizable<String, String>(initialSize: 5, capacity: 99999)
        
        tableResizable["firstName"] = "Steve"
        
        // Expected: ["firstName" : "Steve"]
        print("hash table resizable: \(tableResizable)")
        print("hash table count: \(tableResizable.count)")
        print("hash table size (not count): \(tableResizable.currentTableSize)")
        
        // Expected: "Steve"
        print("hash table value for 'firstName': \(String(describing: tableResizable.value(forKey: "firstName")))")
        
        print("replace entry 'firstName' value with 'Tim'")
        
        tableResizable["firstName"] = "Tim"
        
        // Expected: "Tim"
        print("hash table value for 'firstName': \(String(describing: tableResizable.value(forKey: "firstName")))")
        
        // Expected: ["firstName" : "Tim"]
        print("hash table resizable: \(tableResizable)")
        
        print("delete entry 'firstName'")
        
        tableResizable["firstName"] = nil
        
        // Expected: []
        print("hash table resizable: \(tableResizable)")
    }
    
    func testResizableCollision() {
        print(#function)
        
        var tableResizable = HashTable.Resizable<String, String>(initialSize: 5, capacity: 99999)
        
        tableResizable["hobbies"] = "Test"
        tableResizable["firstName"] = "Check"
        
        print("adding 2 items")
        
        // Expected: ["hobbies" : "Test", "firstName" : "Check", "lastName" : "mate"]
        print("hash table resizable: \(tableResizable)")
        print("hash table count: \(tableResizable.count)")
        print("hash table size (not count): \(tableResizable.currentTableSize)")
        
        print("adding 3rd item, 2 should collide, table should resize...")
        
        tableResizable["lastName"] = "mate"
        
        print("hash table resizable: \(tableResizable)")
        print("hash table count: \(tableResizable.count)")
        print("hash table size (not count): \(tableResizable.currentTableSize)")
    }
}
