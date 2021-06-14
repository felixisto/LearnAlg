//
//  FindLongestArraySum.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 19.05.21.
//

import Foundation

/*
 * Find the longest subarray which elements sum is equal to the given sum.
 * Note that this is about contiguous arrays - elements must always occupy consecutive positions.
 */
class TestFindLongestArraySum {
    func test() {
        let naive = FindLongestArraySumNaive()
        let cache = FindLongestArraySumCache()
        
        // Expected output with sum 8: [-5, 5, 3, 5]
        let array1 = [5, 6, -5, 5, 3, 5, 3, -2, 0]
        let array2 = [5, 3, 6, -5, 5, 3, 5, 3, -2, 0]
        let sum1 = 8
        
        // Expected output with sum 8: [5, 3]
        let array3 = [999, 3, 6, -999, 5, 3, 5, 3, -2, 0]
        
        // Expected output with sum 8: [4, 4]
        let array4 = [4, 4, -999, 55, 3, 77, 23, -2, 0]
        
        print("naive.find array1: \(naive.findElements(in: array1, forSum: sum1))")
        print("naive.find array2: \(naive.findElements(in: array2, forSum: sum1))")
        print("naive.find array3: \(naive.findElements(in: array3, forSum: sum1))")
        print("naive.find array4: \(naive.findElements(in: array4, forSum: sum1))")
        
        print("cache.find array1: \(cache.findElements(in: array1, forSum: sum1))")
        print("cache.find array2: \(cache.findElements(in: array2, forSum: sum1))")
        print("cache.find array3: \(cache.findElements(in: array3, forSum: sum1))")
        print("cache.find array4: \(cache.findElements(in: array4, forSum: sum1))")
    }
}

class FindLongestArraySumNaive {
    // Time complexity: O (n^2)
    // Space complexity: O (1)
    func findIndexes(in data: [Int], forSum sum: Int) -> Range<Int> {
        var range = 0..<0
        
        if data.isEmpty {
            return range
        }
        
        for start in 0..<data.count {
            var subarraySum = 0
            
            for end in start..<data.count {
                subarraySum += data[end]
                
                if subarraySum == sum {
                    let longestLength = range.count
                    let subarrayLength = end - start + 1
                    
                    if longestLength < subarrayLength {
                        let end = end + 1
                        let start = end - subarrayLength
                        range = start..<end
                    }
                }
            }
        }
        
        return range
    }
    
    func findElements(in data: [Int], forSum sum: Int) -> [Int] {
        let range = findIndexes(in: data, forSum: sum)
        if range.isEmpty {
            return []
        }
        return Array(data[range])
    }
}

class FindLongestArraySumCache {
    // Time complexity: O (n)
    // Space complexity: O (n)
    func findIndexes(in data: [Int], forSum sum: Int) -> Range<Int> {
        var range = 0..<0
        
        if data.isEmpty {
            return range
        }
        
        // Insert 0 : -1 to handle case when subarray starts from index 0
        var cache: [Int: Int] = [0 : -1]
        var subarraySum = 0
        
        for e in 0..<data.count {
            subarraySum += data[e]
            
            // if the sum is seen for the first time, insert the sum with its
            // into the map
            if cache[subarraySum] == nil {
                cache[subarraySum] = e
            }
            
            // update length and ending index of the maximum length subarray
            let difference = subarraySum - sum
            let longestLength = range.count
            
            if let start = cache[difference], longestLength < e - start {
                let length = e - start
                let endIndex = e + 1
                let startIndex = endIndex - length
                range = startIndex..<endIndex
            }
        }
        
        return range
    }
    
    func findElements(in data: [Int], forSum sum: Int) -> [Int] {
        let range = findIndexes(in: data, forSum: sum)
        if range.isEmpty {
            return []
        }
        return Array(data[range])
    }
}
