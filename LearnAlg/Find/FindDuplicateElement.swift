//
//  FindDuplicateElement.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 16.05.21.
//

import Foundation

class TestFindDuplicateElement {
    func test() {
        let hashing = FindDuplicateElementWithHashing()
        
        // Expected output: 4
        let data1 = [1, 2, 3, 4, 4]
        
        // Expected output: nil
        let data2 = [1, 2, 3, 4, 0]
        
        var testData = data1
        
        print("hashing.find data1: \(String(describing: hashing.find(in: &testData)))")
        
        testData = data2
        print("hashing.find data2: \(String(describing: hashing.find(in: &testData)))")
    }
}

class FindDuplicateElementWithHashing {
    // Returns the value of the first found duplicate element.
    // Time: O (n)
    // Space: O (n)
    func find(in data: inout [Int]) -> Int? {
        var cache = Set<Int>()
        
        for e in 0..<data.count {
            let value = data[e]
            let isDuplicate = !cache.insert(value).inserted
            
            if isDuplicate {
                return value
            }
        }
        
        return nil
    }
}
