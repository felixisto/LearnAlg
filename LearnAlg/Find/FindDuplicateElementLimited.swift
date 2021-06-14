//
//  FindDuplicateElementLimited.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 16.05.21.
//

import Foundation

/*
 * NOTE: This is about limited range array - all values must be between 1 to n-1!!!
 *
 * It's actually impossible to create a valid array without having duplicate values.
 */
class TestFindDuplicateElementLimited {
    func test() {
        let hashing = FindDuplicateElementLimitedWithHashing()
        let constantSpace = FindDuplicateElementLimitedWithConstantSpace()
        
        // Expected output: 4
        let data1 = [1, 2, 3, 4, 4]
        
        //let data2 = [1, 2, 3, 4] // Crashes, invalid array
        
        var testData = data1
        
        print("hashing.find data1: \(String(describing: hashing.find(in: testData)))")
        
        testData = data1
        
        print("constantSpace.find data1: \(String(describing: constantSpace.find(in: &testData)))")
    }
}

class FindDuplicateElementLimitedWithHashing {
    // Returns the value of the first duplicate element.
    // The given array values must be from 1 to n-1.
    // Time: O (n)
    // Space: O (n)
    func find(in data: [Int]) -> Int? {
        var visited: [Bool] = Array(repeating: false, count: data.count)
        
        for e in 0..<data.count {
            let value = data[e]
            
            if visited[value] {
                return value
            }
            
            visited[value] = true
        }
        
        return -1
    }
}

class FindDuplicateElementLimitedWithConstantSpace {
    // Time: O (n * 2)
    // Space: O (1)
    func find(in data: inout [Int]) -> Int? {
        var duplicate: Int?
        
        for e in 0..<data.count {
            let value = abs(data[e])
            
            if data[value-1] >= 0 {
                data[value-1] *= -1
            } else {
                duplicate = value
                break
            }
        }
        
        // Restore modified elements to their original state
        for e in 0..<data.count {
            if data[e] < 0 {
                data[e] *= -1
            }
        }
        
        return duplicate
    }
}
