//
//  FindLongestConsecutiveSubarray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 18.05.21.
//

import Foundation

/*
 * Find longest subarray by consecutive integers (values differ by 1).
 * Note that this is about contiguous arrays - elements must always occupy consecutive positions.
 *
 * For a subarray to be considered consecutive, the difference between
 * it's max and min elements should be equal to the subarray length, minus 1.
 *
 * Note: element values don't have to be ordered so that the array is considered consecutive.
 * [0, 2, 1, 4, 3] is considered consecutive.
 */
class TestFindLongestConsecutiveSubarray {
    func test() {
        print(#function)
        
        let find = FindLongestConsecutiveSubarray()
        let caching = FindLongestConsecutiveSubarrayWithCaching()
        
        let empty: [Int] = []
        
        let single = [0]
        
        // Expected output: [0, 2, 1, 4, 3]
        let array1 = [2, 0, 2, 1, 4, 3, 1, 0]
        
        // Expected output: [99, 100, 101, 102, 103, 104]
        let array2 = [2, 0, 2, 1, 4, 3, 1, 0, 99, 100, 101, 102, 103, 104, 0]
        
        print("standard.find empty: \(find.findElements(in: empty))")
        print("standard.find single: \(find.findElements(in: single))")
        print("standard.find array1: \(find.findElements(in: array1))")
        print("standard.find array2: \(find.findElements(in: array2))")
        
        print("caching.find empty: \(caching.findElements(in: empty))")
        print("caching.find single: \(caching.findElements(in: single))")
        print("caching.find array1: \(caching.findElements(in: array1))")
        print("caching.find array2: \(caching.findElements(in: array2))")
    }
}

class FindLongestConsecutiveSubarray {
    // Finds the longest subarray with consecutive distinct elements in the given array.
    // Returns the start and end indexes of the found subarray.
    // Time complexity: O (n^3)
    // Space complexity: O (n)
    func findIndexes(in data: [Int]) -> Range<Int> {
        // Function to check if subarray A[start…end] is formed by consecutive integers.
        func isConsecutive(_ start: Int, _ end: Int, _ min: Int, _ max: Int) -> Bool {
            if max - min != end - start {
                return false
            }
            
            var visited: [Bool] = Array(repeating: false, count: end - start + 1)
            
            for e in start..<end {
                let visitIndex = data[e] - min
                
                if visited[visitIndex] {
                    return false
                }
                
                visited[visitIndex] = true
            }
            
            return true
        }
        
        if data.isEmpty {
            return 0..<0
        }
        
        var range: Range<Int> = 0..<1
        
        for start in 0..<data.count {
            var minValue = data[start]
            var maxValue = data[start]
            
            for end in start..<data.count {
                minValue = min(minValue, data[end])
                maxValue = max(maxValue, data[end])
                
                if isConsecutive(start, end, minValue, maxValue) {
                    let length = range.count
                    
                    if length < maxValue - minValue + 1 {
                        range = start..<end+1
                    }
                }
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

class FindLongestConsecutiveSubarrayWithCaching {
    // Finds the longest subarray with consecutive distinct elements in the given array.
    // Returns the start and end indexes of the found subarray.
    // This is similar to the above function, only difference is using set instead of array.
    // Time complexity: O (n^2)
    // Space complexity: O (n)
    func findIndexes(in data: [Int]) -> Range<Int> {
        // Function to check if subarray data[start…end] is formed by consecutive integers.
        func isConsecutive(_ start: Int, _ end: Int, _ min: Int, _ max: Int) -> Bool {
            return max - min == end - start
        }
        
        if data.isEmpty {
            return 0..<0
        }
        
        var range: Range<Int> = 0..<1
        
        var minValue = 0
        var maxValue = 0
        
        for start in 0..<data.count {
            let startValue = data[start]
            
            minValue = startValue
            maxValue = startValue
            
            var set = Set<Int>()
            
            set.insert(startValue)
            
            for end in start+1..<data.count {
                let endValue = data[end]
                minValue = min(minValue, endValue)
                maxValue = max(maxValue, endValue)
                
                // Duplicate elements? Not distinct
                if set.contains(endValue) {
                    break
                }
                
                set.insert(endValue)
                
                // Record new consecutive subarray
                if isConsecutive(start, end, minValue, maxValue) {
                    let length = range.count
                    
                    if length < maxValue - minValue + 1 {
                        range = start..<end+1
                    }
                }
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
