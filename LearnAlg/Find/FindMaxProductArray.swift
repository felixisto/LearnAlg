//
//  FindMaxProductArray.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 19.05.21.
//

import Foundation

class TestFindMaxProductArray {
    func test() {
        let naive = FindMaxProductArrayNaive()
        let quick = FindMaxProductArrayQuick()
        
        // Expected output: [-10, -3]
        let array1 = [-10, -3, 5, 6, -2]
        
        print("naive.find array1 \(naive.findElements(in: array1))")
        print("quick.find array1 \(String(describing: quick.findElements(in: array1)))")
    }
}

class FindMaxProductArrayNaive {
    // Time complexity: O (n^2)
    // Space complexity: O (1)
    func findIndexes(in data: [Int]) -> (Int, Int)? {
        var maxProduct: Int?
        var maxA = 0
        var maxB = 0
        
        for a in 0..<data.count {
            for b in a+1..<data.count {
                let product = data[a] * data[b]
                
                let updateMaxProduct = {
                    maxProduct = product
                    maxA = a
                    maxB = b
                }
                
                if let maxProductSoFar = maxProduct {
                    if maxProductSoFar < product {
                        updateMaxProduct()
                    }
                } else {
                    updateMaxProduct()
                }
            }
        }
        
        if maxProduct == nil {
            return nil
        }
        
        return (maxA, maxB)
    }
    
    func findElements(in data: [Int]) -> [Int] {
        guard let indexes = findIndexes(in: data) else {
            return []
        }
        
        return [data[indexes.0], data[indexes.1]]
    }
}

class FindMaxProductArrayQuick {
    // Returns a pair of elements which makeup the largest product in the given array.
    // Time complexity: O (n)
    // Space complexity: O (1)
    func findElements(in data: [Int]) -> (Int, Int)? {
        if data.isEmpty {
            return nil
        }
        
        var max1 = data[0]
        var max2: Int?
        
        var min1 = data[0]
        var min2: Int?
        
        for e in 1..<data.count {
            let value = data[e]
            
            if value > max1 {
                // if the current element is more than the maximum element,
                // update the maximum and second maximum element
                max2 = max1
                max1 = value
            } else if let max2_ = max2, value > max2_ {
                // if the current element is less than the maximum but greater than the
                // second maximum element, update the second maximum element
                max2 = value
            } else if max2 == nil {
                max2 = value
            }
            
            if value < min1 {
                // if the current element is more than the minimum element,
                // update the minimum and the second minimum
                min2 = min1
                min1 = value
            } else if let min2_ = min2, value < min2_ {
                // if the current element is less than the minimum but greater than the
                // second minimum element, update the second minimum element
                min2 = value
            } else if min2 == nil {
                min2 = value
            }
            
            // otherwise, ignore the element
        }
        
        guard let max2_ = max2 else {
            return nil
        }
        
        guard let min2_ = min2 else {
            return nil
        }
        
        if max1 * max2_ > min1 * min2_ {
            return (max1, max2_)
        } else {
            return (min1, min2_)
        }
    }
}
