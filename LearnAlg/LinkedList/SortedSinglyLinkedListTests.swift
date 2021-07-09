//
//  SortedSinglyLinkedListTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

class SortedSinglyLinkedListTests {
    typealias List = SortedSinglyLinkedList
    
    func test() {
        print(#function)
        
        testInsert()
        testCopy()
        testDelete()
        testCopyAndDelete()
        testRemoveDuplicates()
        testMerge()
    }
    
    func testInsert() {
        print(#function)
        
        var list = List<Int>()
        
        list.append(0)
        list.append(2)
        
        // Expected output: 0
        print("list[0] = \(list[0])")
        
        // Expected output: 2
        print("list[1] = \(list[1])")
        
        list.append(1)
        print("append 1")
        
        // Expected output: 0
        print("list[0] = \(list[0])")
        
        // Expected output: 1
        print("list[1] = \(list[1])")
        
        // Expected output: 2
        print("list[2] = \(list[2])")
    }
    
    func testCopy() {
        print(#function)
        
        var list = List<Int>()
        
        list.append(0)
        list.append(1)
        list.append(2)
        list.append(3)
        
        let listCopyA = list.copy()
        
        // Expected output: [0, 1, 2, 3]
        print("list = \(list)")
        
        // Expected output: [0, 1, 2, 3], last = 3
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
    }
    
    func testDelete() {
        print(#function)
        
        var list = List<Int>()
        
        list.append(0)
        list.append(1)
        
        // Expected output: [0, 1]
        print("list = \(list), last = \(list.last?.value ?? -1)")
        
        list.delete(at: 0)
        print("delete element at index 0")
        
        // Expected output: [1], last = 1
        print("list = \(list), last = \(list.last?.value ?? -1)")
        
        list.delete(at: 0)
        print("delete element at index 0")
        
        // Expected output: [], last = nil
        print("list = \(list), last = \(String(describing: list.last?.value))")
        
        list.append(0)
        print("append 0")
        
        // Expected output: [0], last = 0
        print("list = \(list), last = \(list.last?.value ?? -1)")
    }
    
    func testCopyAndDelete() {
        print(#function)
        
        var list = List<Int>()
        
        list.append(0)
        list.append(1)
        list.append(2)
        list.append(3)
        
        var listCopyA = list.copy()
        
        // Expected output: [0, 1, 2, 3]
        print("list = \(list)")
        
        // Expected output: [0, 1, 2, 3], last = 3
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.delete(at: 0)
        
        print("delete node at 0")
        
        // Expected output: [1, 2, 3], last = 3
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.delete(at: 1)
        
        print("delete node at 1")
        
        // Expected output: [1, 3], last = 3
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.append(4)
        print("append 4")
        
        // Expected output: [1, 3, 4], last = 4
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.append(2)
        print("append 2")
        
        // Expected output: [1, 2, 3, 4], last = 4
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
    }
    
    func testRemoveDuplicates() {
        print(#function)
        
        var list = List<Int>()
        
        list.append(1)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(20)
        list.append(5)
        list.append(5)
        
        // Expected output: [1, 0, 0, 0, 0, 0, 20, 5, 5]
        print("list = \(list)")
        
        list.removeDuplicates()
        
        // Expected output: [1, 0, 20, 5], last = 5
        print("list without duplicates = \(list), last = \(list.last?.value ?? -1)")
        
        list = List<Int>()
        
        list.append(1)
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        // Expected output: [1, 1, 0, 20, 5]
        print("list = \(list)")
        
        list.removeDuplicates()
        
        // Expected output: [1, 0, 20, 5], last = 5
        print("list without duplicates = \(list), last = \(list.last?.value ?? -1)")
    }
    
    func testMerge() {
        print(#function)
        
        var listA = List<Int>()
        
        listA.append(0)
        listA.append(2)
        listA.append(4)
        
        var listB = List<Int>()
        
        listB.append(-1)
        listB.append(1)
        listB.append(3)
        
        // Expected output: [0, 2, 4]
        print("listA = \(listA)")
        
        // Expected output: [-1, 1, 3]
        print("listB = \(listB)")
        
        listA.merge(with: listB.first!)
        
        // Expected output: [0, 2, 4, -1, 1, 3], last = 3
        print("merged lists = \(listA), last = \(listA.last?.value ?? -1)")
        
        var listC = List<Int>()
        listC.append(0)
        
        var listD = List<Int>()
        listD.append(1)
        
        // Expected output: [0]
        print("listC = \(listC)")
        
        // Expected output: [1]
        print("listD = \(listD)")
        
        listC.merge(with: listD.first!)
        
        // Expected output: [0, 1], last = 1
        print("merged lists = \(listC), last = \(listC.last?.value ?? -1)")
    }
}
