//
//  SortBinary.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 16.05.21.
//

import Foundation

class TestSortBinary {
    func test() {
        let sort = SortBinary()
        
        let data1 = [1, 0, 1, 0, 1, 0, 0, 1]
        var testData = data1
        
        print("sortSimple data1: \(sort.sortSimple(&testData))")
        
        testData = data1
        print("quickSort data1: \(sort.quickSort(&testData))")
        
    }
}

class SortBinary {
    // Sorts the given array so that zeros come first.
    // Time complexity: O (n * 2)
    // Space complexity: O (1)
    func sortSimple(_ data: inout [Int]) -> [Int] {
        var countZeroes = 0
        
        for e in 0..<data.count {
            if data[e] == 0 {
                countZeroes += 1
            }
        }
        
        for e in 0..<data.count {
            if countZeroes > 0 {
                countZeroes -= 1
                
                data[e] = 0
            } else {
                data[e] = 1
            }
        }
        
        return data
    }
    
    // Sorts the given array so that zeros come first.
    // Time complexity: O (n * 2)
    // Space complexity: O (1)
    func quickSort(_ data: inout [Int]) -> [Int] {
        func swap(a: Int, b: Int) {
            let temp = data[a]
            data[a] = data[b]
            data[b] = temp
        }
        
        let pivot = 1
        var position = 0
        
        for e in 0..<data.count {
            // each time we encounter a 0, `position` is incremented, and
            // 0 is placed before the pivot
            if data[e] < pivot {
                swap(a: e, b: position)
                
                position += 1
            }
        }
        
        return data
    }
}
