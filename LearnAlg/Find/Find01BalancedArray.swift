//
//  Find01BalancedArray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 19.05.21.
//

import Foundation

/*
 * Find longest subarray whose number of zeroes is equal to its number of ones.
 * Note that this is about contiguous arrays - elements must always occupy consecutive positions.
 */
class TestFind01BalancedArray {
    func test() {
        let find = Find01BalancedArray()
        
        // Expected output: [1, 0, 1, 0]
        let array1 = [0, 0, 1, 0, 1, 0, 0]
        
        print("find array1: \(find.findElements(in: array1))")
    }
}

class Find01BalancedArray {
    // Time complexity: O (n)
    // Space complexity: O (n)
    func findIndexes(in data: [Int]) -> Range<Int> {
        var range = 0..<0
        
        if data.isEmpty {
            return range
        }
        
        // Insert 0 : -1 to handle case when subarray starts from index 0
        var cache: [Int: Int] = [0 : -1]
        var subarraySum = 0
        
        for e in 0..<data.count {
            // We use the sum to find if we have reached a balanced subarray
            // of zeroes and one
            subarraySum += data[e] == 0 ? -1 : 1
            
            if let sum = cache[subarraySum] {
                let subarrayLength = e - sum
                
                // Check if currect balanced subarray is longer than previously recorded
                let length = range.count
                
                if length < subarrayLength {
                    let end = e + 1
                    let start = end - subarrayLength
                    range = start..<end
                }
            } else {
                // if the sum is seen for the first time, insert the sum with its
                // index into the map
                cache[subarraySum] = e
            }
        }
        
        return range
    }
    
    func findElements(in data: [Int]) -> [Int] {
        let range = findIndexes(in: data)
        if range.isEmpty {
            return []
        }
        return Array(data[range])
    }
}
