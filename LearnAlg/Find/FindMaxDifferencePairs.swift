//
//  FindMaxDifferencePairs.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 20.05.21.
//

import Foundation

class TestFindMaxDifferencePairs {
    func test() {
        print(#function)
        
        let naive = FindMaxDifferencePairsNaive()
        let efficient = FindMaxDifferencePairsEfficient()
        
        // Expected output: 7
        let array1 = [2, 7, 9, 5, 1, 3, 5]
        
        print("naive.find \(String(describing: naive.find(in: array1)))")
        print("efficient.find \(String(describing: efficient.find(in: array1)))")
    }
}

class FindMaxDifferencePairsNaive {
    // Time complexity: O (n^2)
    // Space complexity: O (1)
    func findPairs(in data: [Int]) -> (Int, Int)? {
        if data.count <= 1 {
            return nil
        }
        
        var a = 0
        var b = 0
        var min: Int?
        
        for e in 0..<data.count {
            for i in e+1..<data.count {
                let eValue = data[e]
                let iValue = data[i]
                
                let updateMin = {
                    a = e
                    b = i
                    min = eValue - iValue
                }
                
                if let minValue = min {
                    if minValue > eValue - iValue {
                        updateMin()
                    }
                } else {
                    updateMin()
                }
            }
        }
        
        return (a, b)
    }
    
    // Result value is returned as positive.
    func find(in data: [Int]) -> Int? {
        guard let indexes = findPairs(in: data) else {
            return nil
        }
        
        return abs(data[indexes.0] - data[indexes.1])
    }
}

class FindMaxDifferencePairsEfficient {
    // Result value is returned as positive.
    // Time complexity: O (n)
    // Space complexity: O (1)
    func find(in data: [Int]) -> Int? {
        if data.count <= 1 {
            return nil
        }
        
        var maxDifference: Int?
        var maxSoFar = data[data.count-1]
        
        var e = data.count - 2
        
        while e >= 0 {
            let value = data[e]
            
            if value > maxSoFar {
                maxSoFar = data[e]
            }
            
            let diff = maxSoFar - value
            
            if let difference = maxDifference {
                if difference < diff {
                    maxDifference = diff
                }
            } else {
                maxDifference = diff
            }
            
            e -= 1
        }
        
        return maxDifference
    }
}
