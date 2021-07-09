//
//  LinkedListLRUCacheTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.07.21.
//

import Foundation

import Foundation

class LinkedListLRUCacheTests {
    typealias Cache = LinkedListLRUCache
    
    func test() {
        print(#function)
        
        testEviction()
    }
    
    func testEviction() {
        print(#function)
        
        let capacity = 2
        let cache = Cache(capacity)
        
        // cache is []
        print("cache: \(cache) with capacity \(capacity)")
        
        print("cache put 1,1")
        cache.put(1, 1)
        
        // cache is [1=1]
        print("cache: \(cache)")
        
        print("cache put 2,2")
        cache.put(2, 2)
        
        // cache is [1=1, 2=2]
        print("cache: \(cache)")
        
        // cache get 1 = 1
        print("cache get 1 = \(String(describing: cache.get(1)))")
        
        // cache is [2=2, 1=1]
        print("cache: \(cache)")
        
        // Capacity is 2, so cache should have evicted [2,2]
        print("cache put 3,3 (capacity \(capacity) should now be exceeded, evict [2,2])")
        cache.put(3, 3)
        
        // cache is [1=1, 3=3]
        print("cache: \(cache)")
        
        // cache get 2 = nil (not found)
        print("cache get 2 = \(String(describing: cache.get(2)))")
        
        print("cache put 4,4")
        cache.put(4, 4)
        
        // LRU key was 1, evicts key 1, cache is [4=4, 3=3]
        print("cache: \(cache)")
        
        // cache get 1 = nil (not found)
        print("cache get 1 = \(String(describing: cache.get(1)))")
        
        // cache get 3 = 3
        print("cache get 3 = \(String(describing: cache.get(3)))")
        
        // cache get 4 = 4
        print("cache get 4 = \(String(describing: cache.get(4)))")
    }
}
