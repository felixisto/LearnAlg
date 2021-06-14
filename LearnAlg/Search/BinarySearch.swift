//
//  BinarySearch.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 3.06.21.
//

import Foundation

class TestBinarySearch {
    func test() {
        let search = BinarySearch()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [5]
        
        // Expected output: 3
        print("find 5: \(String(describing: search.find(value: 5, in: array1)))")
        
        // Expected output: 0
        print("find 5: \(String(describing: search.find(value: 5, in: array2)))")
        
        // Expected output: nil
        print("find 6: \(String(describing: search.find(value: 6, in: array2)))")
    }
}

class BinarySearch {
    func contains(value: Int, in data: [Int]) -> Bool {
        return find(value: value, in: data) != nil
    }
    
    func find(value: Int, in data: [Int]) -> Int? {
        if data.isEmpty {
            return nil
        }
        
        let sorted = data.sorted()
        
        var start = 0
        var end = sorted.count - 1
        
        while start <= end {
            let position = end / 2
            
            let element = sorted[position]
            
            if value == element {
                return position
            } else if element > value {
                // Too big
                end = position - 1
            } else {
                // Too small
                start = position + 1
            }
        }
        
        return nil
    }
}
