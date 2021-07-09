//
//  FindSum.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

/*
 * Count all pairs with given sum.
 * Pairs may include the same index twice.
 *
 * Negative and duplicate values are allowed.
 *
 * Note: Seemed impossible to solve as long as duplicates are allowed but
 * looks like I found a way - with hashing map and also including
 * special case check for element pair with itself.
 */
class TestFindSumPairs {
    func test() {
        print(#function)
        
        let bruteForce = FindSumPairsBruteForce()
        let hashing = FindSumPairsWithHashing()
        
        // Expected output with k 6: 7
        let array1 = [1, 8, -3, 0, 1, 3, -2, 4, 5]
        
        // Expected output with k 6: 6
        let array2 = [1, 5, -10, 100, 50, 80, 55, 66, 23, 3, 3]
        
        let k1 = 6
        
        print("bruteForce.find array1: \(bruteForce.count(k: k1, array: array1))")
        print("hashing.find array1: \(hashing.count(k: k1, array: array1))")
        
        print("bruteForce.find array2: \(bruteForce.count(k: k1, array: array2))")
        print("hashing.find array2: \(hashing.count(k: k1, array: array2))")
    }
}

class FindSumPairsBruteForce {
    // Time complexity: O (n^2)
    // Space complexity: O (1)
    func count(k: Int, array data: [Int]) -> Int {
        var count = 0
        
        for e in 0..<data.count {
            for i in 0..<data.count {
                if data[e] + data[i] == k {
                    //print("\(data[e]), \(data[i])")
                    count += 1
                }
            }
        }
        
        return count
    }
}

class FindFirstSumPairsWithMarching {
    // Time complexity: O (n * log(n))
    // Space complexity: O (1)
    func find(k: Int, array data: [Int]) -> Bool {
        if data.isEmpty {
            return false
        }
        
        var array = data
        
        array.sort() // O ( log(n) )
        
        var low = 0
        var high = array.count - 1
        
        for _ in 0..<array.count { // O ( n )
            let sum = array[low] + array[high]
            
            if sum == k {
                return true
            } else if sum > k {
                // Too high
                high -= 1
            } else {
                // Too low
                low += 1
            }
        }
        
        return false
    }
}

class FindSumPairsWithHashing {
    // Time complexity: O (n)
    // Space complexity: O (n)
    func count(k: Int, array data: [Int]) -> Int {
        let array = data
        var cache: [Int: Int] = [:]
        var count = 0
        
        for e in 0..<array.count {
            let value = array[e]
            let complement = k - value
            var occurences = cache[value] ?? 0

            if let c = cache[complement] {
                //print("e = \(e). complement = \(complement) c = \(c)")
                
                occurences = c
                count += occurences * 2
            }
            
            cache[value] = occurences + 1
            
            // Special case, the element itself may be used twice
            if value * 2 == k {
                count += 1
            }
        }
        
        return count
    }
}

class FindSumPairsNotWorking {
    /*
    func incorrectFindWithHashingB(k: Int, array data: [Int]) -> Int {
        var cache: [Int: Int] = [:]
        
        for e in 0..<data.count {
            cache[data[e]] = (cache[data[e]] ?? 0) + 1
        }
        
        var twiceCount = 0
        
        // iterate through each element and increment the
        for e in 0..<data.count {
            var value = data[e]
            var difference = k - value
            
            if let sum = cache[difference] {
                twiceCount += sum
            }
            
            // if (arr[i], arr[i]) pair satisfies the
            // condition, then we need to ensure that the
            // count is decreased by one such that the
            // (arr[i], arr[i]) pair is not considered
            value = data[e]
            difference = k - value
            
            if difference == value {
                twiceCount -= 1
            }
        }
        
        return twiceCount / 2
    }
    
    func incorrectFindWithHashingC(k: Int, array data: [Int]) -> Int {
        // Trash, does not work with duplicates
        var visitedValues = Set<Int>()
        var pairs = [(Int, Int)]()
        for e in 0..<data.count {
            let value = data[e]
            let complement = k - value

            if visitedValues.contains(complement) {
                pairs.append((value, complement))
            }
            visitedValues.insert(value)
        }

        count = pairs.count * 2
    }
    
    // This doesnt work unless its for only finding one pair.
    func incorrectSortAndFindByEnds(k: Int, array data: [Int]) -> Int {
        if data.count <= 1 {
            return 0
        }
        
        var array = data
        var complementaryElements = 0
        
        array.sort()
        
        var lowest = 0
        var highest = array.count - 1
        
        while lowest <= highest {
            let sum = array[lowest] + array[highest]

            if sum == k {
                //print("\(array[lowest]), \(array[highest])")
                
                if lowest == highest {
                    complementaryElements += 1
                } else {
                    //print("\(array[highest]), \(array[lowest])")
                    complementaryElements += 2
                }
                
                // Can't just move lowest or highest or both:
                // Will not work when theres duplicates
                
                lowest += 1
                //highest -= 1
                continue // Return if looking only for the first one
            }

            if sum < k {
                lowest += 1
            } else {
                highest -= 1
            }
        }
        
        return complementaryElements
    }*/
}
