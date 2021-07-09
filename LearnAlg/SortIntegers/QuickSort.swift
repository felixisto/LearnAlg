//
//  QuickSort.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 3.06.21.
//

import Foundation

class TestQuickSort {
    func test() {
        print(#function)
        
        let sort = QuickSort()
        
        let array1 = [-2, 4, 20, 5, 7, 100, -50, 66]
        let array2 = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
        
        print("quicksort \(array1) -> \(sort.sort(array1))")
        print("quicksort \(array2) -> \(sort.sort(array2))")
        
        var test = array1
        sort.sort(&test)
        print("quicksort \(array1) -> \(test))")
        
        test = array2
        sort.sort(&test)
        print("quicksort \(array2) -> \(test)")
    }
}

/*
 * Quicksort (sometimes called partition-exchange sort) is an efficient sorting algorithm.
 *
 * Quicksort is a divide-and-conquer algorithm. It works by selecting a 'pivot'
 * element from the array and partitioning the other elements into two sub-arrays,
 * according to whether they are less than or greater than the pivot.
 * The sub-arrays are then sorted recursively.
 *
 * Best-case: simple partition O(n log n)
 * Average performance: O(n log n)
 * Worst-case: O(n^2)
 * Worst-case space complexity: naive O(log n)
 * Stable: no
 * Strategy: partioning
 */
class QuickSort {
    // Space complexity: O(1)
    func sort(_ data: inout [Int]) {
        func partition(low: Int, high: Int) -> Int {
            let pivot = data[high]
            
            var result = low
            
            // Sort all the values based on the pivot
            for e in low..<high {
                if data[e] <= pivot {
                    data.swapAt(result, e)
                    result += 1
                }
            }
            
            data.swapAt(result, high)
            
            return result
        }
        
        func sort(low: Int, high: Int) {
            if low >= high {
                return
            }
            
            let pivot = partition(low: low, high: high)
            sort(low: low, high: pivot - 1)
            sort(low: pivot + 1, high: high)
        }
        
        sort(low: 0, high: data.count - 1)
    }
    
    // Space complexity: O(n)
    func sort(_ data: [Int]) -> [Int] {
        guard data.count > 1 else {
            return data
        }
        
        let pivot = data[data.count/2]
        let less = data.filter { $0 < pivot }
        let equal = data.filter { $0 == pivot }
        let greater = data.filter { $0 > pivot }
        
        return sort(less) + equal + sort(greater)
    }
}
