//
//  MergeSort.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 3.06.21.
//

import Foundation

class TestMergeSort {
    func test() {
        let sort = MergeSort()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
        
        print("merge sort \(array1) -> \(sort.sort(array1)))")
        print("merge sort \(array2) -> \(sort.sort(array2))")
    }
}

/*
 * Efficient, general-purpose, divide and conquer and comparison-based sorting algorithm.
 *
 * Works in 2 steps:
 * 1. Divide the unsorted list into n sublists, each containing one element (a list of one element is considered sorted).
 * 2. Repeatedly merge sublists to produce new sorted sublists until there is only one sublist remaining. This will be the sorted list.
 *
 * Comparing it to quicksort, this algorithm is slightly faster but takes more space.
 *
 * Best-case: O(n log n)
 * Average performance: O(n log n)
 * Worst-case: O(n log n)
 * Worst-case space complexity: O(n)
 * Stable: yes
 * Strategy: merging
 */
class MergeSort {
    // Space complexity: O(n)
    func sort(_ data: [Int]) -> [Int] {
        if data.count <= 1 {
            return data
        }
        
        func merge(leftPile: inout [Int], rightPile: inout [Int]) -> [Int] {
            var leftIndex = 0
            var rightIndex = 0

            var orderedPile = [Int]()
            orderedPile.reserveCapacity(leftPile.count + rightPile.count)

            while leftIndex < leftPile.count && rightIndex < rightPile.count {
                if leftPile[leftIndex] < rightPile[rightIndex] {
                  orderedPile.append(leftPile[leftIndex])
                  leftIndex += 1
                } else if leftPile[leftIndex] > rightPile[rightIndex] {
                  orderedPile.append(rightPile[rightIndex])
                  rightIndex += 1
                } else {
                  orderedPile.append(leftPile[leftIndex])
                  leftIndex += 1
                  orderedPile.append(rightPile[rightIndex])
                  rightIndex += 1
                }
            }

            while leftIndex < leftPile.count {
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
            }

            while rightIndex < rightPile.count {
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }

            return orderedPile
        }
        
        let middleIndex = data.count / 2
        var leftArray = sort(Array(data[0..<middleIndex]))
        var rightArray = sort(Array(data[middleIndex..<data.count]))
        
        return merge(leftPile: &leftArray, rightPile: &rightArray)
    }
}
