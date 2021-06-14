//
//  InsertionSort.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 3.06.21.
//

import Foundation

class TestInsertionSort {
    func test() {
        let sort = InsertionSort()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
        
        var test = array1
        sort.sort(&test)
        print("insertion sort \(array1) -> \(test))")
        
        test = array2
        sort.sort(&test)
        print("insertion sort \(array2) -> \(test)")
    }
}

/*
 * Insertion sort is a simple sorting algorithm that builds the final sorted array one item at a time.
 *
 * Insertion sort iterates, consuming one input element each repetition,
 * and grows a sorted output list. At each iteration, insertion sort removes one element from the input data,
 * finds the location it belongs within the sorted list, and inserts it there.
 * It repeats until no input elements remain.
 *
 * Best-case: O(n)
 * Average performance: O(n^2)
 * Worst-case: O(n^2)
 * Worst-case space complexity: O(1)
 * Stable: yes
 * Strategy: swapping
 */
class InsertionSort {
    // Space complexity: O(1)
    func sort(_ data: inout [Int]) {
        let max = data.count
        var key = 0
        
        // We loop trough all elements in the original array from the second element
        for e in 1..<max {
            // Store the current element as the key
            key = data[e]
            
            // Get the element index just before the current element index
            var previous = e - 1
            
            // Loop trough all elements from the key to the start
            // Check if the current element is smaller than the key
            while previous >= 0 && data[previous] > key {
                // We move the current element backwards
                data[previous + 1] = data[previous]
                previous -= 1
            }
            
            // We finally move the key
            data[previous + 1] = key
        }
    }
}
