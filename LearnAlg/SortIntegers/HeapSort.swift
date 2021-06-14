//
//  HeapSort.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 7.06.21.
//

import Foundation

class TestHeapSort {
    func test() {
        let sort = HeapSort()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
        
        var test = array1
        sort.sort(&test)
        print("heap sort \(array1) -> \(test))")
        
        test = array2
        sort.sort(&test)
        print("heap sort \(array2) -> \(test)")
    }
}

/*
 * Heapsort is a comparison-based sorting algorithm.
 *
 * Heapsort can be thought of as an improved selection sort: like selection sort, heapsort divides its input into a sorted and an unsorted region,
 * and it iteratively shrinks the unsorted region by extracting the largest element from it and inserting it into the sorted region.
 *
 * Best-case: O(n log n)
 * Average performance: O(n log n)
 * Worst-case: O(n log n)
 * Worst-case space complexity: O(1) - yes, O(1)
 * Stable: no
 * Strategy: selection
 */
class HeapSort {
    // Space complexity: O(1)
    func sort(_ data: inout [Int]) {
        func heapify(index: Int, size: Int) {
            // Init largest as root
            var largest = index
            let left = (2 * index) + 1
            let right = (2 * index) + 2
            
            if left < size && data[left] > data[largest] {
                largest = left
            }
            
            if right < size && data[right] > data[largest] {
                largest = right
            }
            
            // Is largest not root?
            if largest != index {
                data.swapAt(index, largest)
                
                // Recursively heapify the affected sub-tree
                heapify(index: largest, size: size)
            }
        }
        
        // Build heap
        let size = data.count
        var i = (size / 2) - 1
        
        while i >= 0 {
            heapify(index: i, size: size)
            
            i -= 1
        }
        
        // Fix the partially sorted array
        // One by one extract the elements from the heap
        for e in stride(from: size-1, to: 0, by: -1) {
            // Move current root to end
            data.swapAt(0, e)
            
            // Call max heapify on the reduced heap
            heapify(index: 0, size: e)
        }
    }
}
