//
//  FindEquilibriumIndex.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 19.05.21.
//

import Foundation

/*
 * Find equilibrium index of an array.
 *
 * For an array A consisting n elements, index i is an equilibrium index if the sum of elements of subarray A[0...i-1] is equal to the sum of elements of subarray A[i+1...n-1]
 */
class TestFindEquilibriumIndex {
    func test() {
        let linear = FindEquilibriumIndexLinear()
        let linearSpaceless = FindEquilibriumIndexLinearSpaceless()
        
        // Expected output: [0, 3, 7]
        let array1 = [0, -3, 5, -4, -2, 3, 1, 0]
        
        print("linear.find array1 \(String(describing: linear.find(in: array1)))")
        print("linearSpaceless.find array1 \(String(describing: linearSpaceless.find(in: array1)))")
    }
}

class FindEquilibriumIndexLinear {
    // Returns all the equilibrium indexes.
    // Time complexity: O (n * 2)
    // Space complexity: O (n)
    func find(in data: [Int]) -> [Int] {
        var result: [Int] = []
        
        // `leftValues` stores the sum of elements of subarray `data[0…i-1]`
        var leftValues: [Int] = Array(repeating: 0, count: data.count)
        
        leftValues[0] = 0
        
        for e in 1..<data.count {
            leftValues[e] = leftValues[e - 1] + data[e - 1]
        }
        
        // `rightValue` stores the sum of elements of subarray `data[i+1…n)`
        var rightValue = 0
        
        // traverse the array from right to left
        var i = data.count - 1
        
        while i >= 0  {
            if leftValues[i] == rightValue {
                //print("Equilibrium Index found at \(i)")
                result.append(i)
            }
            
            rightValue += data[i]
            
            i -= 1
        }
        
        return result.reversed()
    }
}

class FindEquilibriumIndexLinearSpaceless {
    // Returns all the equilibrium indexes.
    // Time complexity: O (n * 2)
    // Space complexity: O (1)
    func find(in data: [Int]) -> [Int] {
        func sum(of data: [Int]) -> Int {
            var total = 0
            
            for e in 0..<data.count {
                total += data[e]
            }
            
            return total
        }
        
        var result: [Int] = []
        
        // `totalSum` stores the sum of all the array elements
        let totalSum = sum(of: data)
        
        // `rightValue` stores the sum of elements of subarray `data[i+1…n)`
        var rightValue = 0
        
        // traverse the array from right to left
        var i = data.count - 1
        
        while i >= 0  {
            // sum of elements of the left subarray `data[0…i-1]` is
            // (total - (data[i] + rightValue))
            if rightValue == totalSum - (data[i] + rightValue) {
                //print("Equilibrium Index found at \(i)")
                result.append(i)
            }
            
            rightValue += data[i]
            
            i -= 1
        }
        
        // Ignored by complexity
        return result.reversed()
    }
}
