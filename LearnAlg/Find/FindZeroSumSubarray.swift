//
//  FindZeroSumSubarray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 15.05.21.
//

import Foundation

/*
 * Find a contiguous subarray whose sum is equal to zero.
 *
 * Note that the subarrays are always contiguous AKA
 * it's must be made of elements that occupy consecutive positions.
 */
class TestFindZeroSumSubarray {
    func test() {
        print(#function)
        
        let find = FindZeroSumSubarray()
        
        // Expected output: [[3, 4, -7], [4, -7, 3], [-7, 3, 1, 3], [3, 1, -4], [3, 4, -7, 3, 1, 3, 1, -4, -2, -2], [3, 1, 3, 1, -4, -2, -2]]
        let array1 = [3, 4, -7, 3, 1, 3, 1, -4, -2, -2]
        
        // Expected output: [[0], [-3, -1, 0, 4]]
        let array2 = [4, 2, -3, -1, 0, 4]
        
        var result = find.findAll(array: array1)
        print("findAll of array1: \(result)")
        
        result = find.findAll(array: array2)
        print("findAll of array2: \(result)")
        
        var flag = find.findFirst(array: array1)
        print("findFirst of array1: \(flag)")
        
        flag = find.findFirst(array: array2)
        print("findFirst of array2: \(flag)")
        
        flag = find.findFirst(array: array2, offsetSum: 6)
        print("findFirst with offset 6 of array2: \(flag)")
        
        flag = find.findFirst(array: array2, offsetSum: 8)
        print("findFirst with offset 8 of array2: \(flag)")
    }
}

class FindZeroSumSubarray {
    // Check if a zero sum subarray exists in the given array.
    // Time: O (n)
    // Space: O (n)
    func findFirst(array: [Int], offsetSum: Int = 0) -> Bool {
        var cache = Set<Int>()
        
        cache.insert(0)
        
        var sum = 0
        
        for e in 0..<array.count {
            sum += array[e] - offsetSum
            
            // Idea is to "balance" the sum we have found so far
            if cache.contains(sum) {
                return true
            } else {
                cache.insert(sum)
            }
        }
        
        return false
    }
    
    // Collect all zero sum subarrays from the given array.
    // Time: O (n)
    // Space: O (n)
    func findAll(array: [Int], offsetSum: Int = 0) -> [[Int]] {
        var subarrays = [[Int]]()
        var multimap = [Int : [Int]]()
        
        func insert(key: Int, value: Int) {
            if multimap[key] == nil {
                multimap[key] = []
            }
            
            multimap[key]?.append(value)
        }
        
        insert(key: 0, value: -1)
        
        var sum = 0
        
        for e in 0..<array.count {
            sum += array[e] - offsetSum
            
            if let list = multimap[sum] {
                for el in list {
                    var subarray = [Int]()
                    
                    for i in el+1...e {
                        subarray.append(array[i])
                    }
                    
                    subarrays.append(subarray)
                }
            }
            
            insert(key: sum, value: e)
        }
        
        return subarrays
    }
}
