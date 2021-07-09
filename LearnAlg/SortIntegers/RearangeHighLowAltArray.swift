//
//  RearangeHighLowAltArray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 19.05.21.
//

import Foundation

class TestRearangeHighLowAltArray {
    func test() {
        print(#function)
        
        let sort = RearangeHighLowAltArray()
        
        let array1 = [1, 2, 3, 4, 5, 6, 7]
        let array2 = [9, 6, 8, 3, 7]
        let array3 = [6, 9, 2, 5, 1, 4]
        let array4 = [4, 3, 5, 2, 6, 1, 7]
        
        var test = array1
        
        sort.sort(in: &test)
        print("sort array1: \(test)")
        
        test = array2
        sort.sort(in: &test)
        print("sort array2: \(test)")
        
        test = array3
        sort.sort(in: &test)
        print("sort array3: \(test)")
        
        test = array4
        sort.sort(in: &test)
        print("sort array4: \(test)")
    }
}

class RearangeHighLowAltArray {
    // Time complexity: O (n)
    // Space complexity: O (1)
    func sort(in data: inout [Int]) {
        func swap(_ a: Int, _ b: Int) {
            let temp = data[a]
            data[a] = data[b]
            data[b] = temp
        }
        
        var e = 1
        
        while e < data.count {
            // if the previous element is greater than the current element,
            // swap the elements
            if data[e - 1] > data[e] {
                swap(e - 1, e)
            }
            
            // if the next element is greater than the current element,
            // swap the elements
            if e + 1 < data.count && data[e + 1] > data[e] {
                swap(e + 1, e)
            }
            
            e += 2
        }
    }
}
