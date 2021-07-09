//
//  FindMajorityElement.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 20.05.21.
//

import Foundation

/*
 * Find the most common occuring value.
 */
class TestFindMajorityElement {
    func test() {
        print(#function)
        
        let brute = FindMajorityElementBruteForce()
        let hashing = FindMajorityElementHashing()
        let boyerMoore = FindMajorityElementBoyerMoore()
        
        // Expected output: 2
        let array1 = [2, 8, 7, 2, 2, 5, 2, 3, 1, 2, 2]
        
        // Expected output: 2
        let array2 = [2, 2, 2, 2, 2, 1, 3, 4, 5, 6, 2]
        
        print("brute.find array1: \(String(describing: brute.find(in: array1)))")
        print("brute.find array2: \(String(describing: brute.find(in: array2)))")
        
        print("hashing.find array1: \(String(describing: hashing.find(in: array1)))")
        print("hashing.find array2: \(String(describing: hashing.find(in: array2)))")
        
        print("boyerMoore.find array1: \(String(describing: boyerMoore.find(in: array1)))")
        print("boyerMoore.find array2: \(String(describing: boyerMoore.find(in: array2)))")
    }
}

class FindMajorityElementBruteForce {
    // Time complexity: O (n^2)
    // Space complexity: O (1)
    func find(in data: [Int]) -> Int? {
        if data.count == 1 {
            return data[0]
        }
        
        let size = data.count
        
        for e in 0..<size { // Note: do NOT use size/2, does not work properly
            let currentValue = data[e]
            
            var counter = 1
            
            for i in e+1..<size {
                if data[i] == currentValue {
                    counter += 1
                    
                    if counter > size / 2 {
                        return currentValue
                    }
                }
            }
        }
        
        return nil
    }
}

class FindMajorityElementHashing {
    // Time complexity: O (n)
    // Space complexity: O (n)
    func find(in data: [Int]) -> Int? {
        if data.count == 1 {
            return data[0]
        }
        
        let size = data.count
        
        var frequency: [Int : Int] = [:]
        
        for e in 0..<size {
            let value = data[e]
            
            if let frequencyValue = frequency[value] {
                let newFrequencyValue = frequencyValue + 1
                frequency[value] = newFrequencyValue
                
                if newFrequencyValue > size / 2 {
                    return value
                }
            } else {
                frequency[value] = 1
            }
        }
        
        return nil
    }
}

class FindMajorityElementBoyerMoore {
    // Time complexity: O (n)
    // Space complexity: O (1)
    func find(in data: [Int]) -> Int? {
        let size = data.count
        
        var result: Int?
        var candidateCounter = 0
        
        for e in 0..<size {
            if candidateCounter == 0 {
                result = data[e]
                candidateCounter = 1
            } else if let r = result {
                if data[e] == r {
                    candidateCounter += 1
                } else {
                    candidateCounter -= 1
                }
            }
        }
        
        return result
    }
}
