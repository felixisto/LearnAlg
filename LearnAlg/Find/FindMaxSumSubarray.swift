//
//  FindMaxSumSubarray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 20.05.21.
//

import Foundation

/*
 * Find the largest contiguous subarray sum.
 *
 * Note that the subarrays are always contiguous AKA
 * it's must be made of elements that occupy consecutive positions.
 */
class TestFindMaxSumSubarray {
    func test() {
        let kadane = FindMaxSumSubarrayKadane()
        
        // Expected output: 6
        let array1 = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        
        // Expected output: -2
        let array2 = [-8, -3, -6, -2, -5, -4]
        
        print("kadane.find: \(kadane.find(in: array1))")
        print("kadane.find: \(kadane.find(in: array2))")
    }
}

class FindMaxSumSubarrayKadane {
    // Time complexity: O (n)
    // Space complexity: O (1)
    func find(in data: [Int]) -> Int {
        if data.isEmpty {
            return 0
        }
        
        // stores the maximum sum subarray found so far
        var maxSum = data[0]
        
        // stores the maximum sum of subarray ending at the current position
        var maxSumCurrent = data[0]
        
        for e in 1..<data.count {
            // update the maximum sum of subarray "ending" at index `e` (by adding the
            // current element to maximum sum ending at previous index `e-1`)
            maxSumCurrent += data[e]
            
            // maximum sum should be more than the current element
            maxSumCurrent = max(maxSumCurrent, data[e])
            
            // update the result if the current subarray sum is found to be greater
            maxSum = max(maxSum, maxSumCurrent)
        }
        
        return maxSum
    }
}
