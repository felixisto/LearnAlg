//
//  BubbleSorting.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 7.06.21.
//

import Foundation

class TestBubbleSort {
    func test() {
        let sort = InsertionSort()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
        
        var test = array1
        sort.sort(&test)
        print("bubble sort \(array1) -> \(test))")
        
        test = array2
        sort.sort(&test)
        print("bubble sort \(array2) -> \(test)")
    }
}

/*
 * Bubble sort, also referred to as sinking sort is a sorting algorithm.
 *
 * Works by repeatedly stepping through a list,
 * compares adjacent elements and swaps them if they are in the wrong order.
 *
 * Another thing about the bubble sort is its tiny code size compared to other sorting algorithms.
 *
 * Best-case: O(n)
 * Average performance: O(n^2)
 * Worst-case: O(n^2)
 * Worst-case space complexity: O(1)
 * Stable: yes
 * Strategy: swapping
 */
class BubbleSort {
    // Space complexity: O(1)
    func sort(_ data: inout [Int]) {
        for i in 0..<data.count {
            for e in 0..<data.count-i-1 {
                if data[e+1] < data[e] {
                    data.swapAt(e+1, e)
                }
            }
        }
    }
}
