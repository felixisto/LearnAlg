//
//  SortedSinglyLinkedListTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

class SortedSinglyLinkedListTests {
    func test() {
        testInsert()
        testCopy()
        testCopyAndDelete()
        testRemoveDuplicates()
        testMerge() 
    }
    
    func testInsert() {
        var list = SortedSinglyLinkedList<Int>()
        
        list.append(1)
        list.append(0)
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        
        print("append '2'")
        list.append(2)
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        print("list[2] = \(list[2])")
    }
    
    func testCopy() {
        var list = SortedSinglyLinkedList<Int>()
        
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        let listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
    }
    
    func testCopyAndDelete() {
        var list = SortedSinglyLinkedList<Int>()
        
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        var listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.delete(at: 0)
        
        print("delete node at 0")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.delete(at: 1)
        
        print("delete node at 1")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.append(6)
        
        print("append '6'")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.append(6)
        
        print("append '6'")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
        
        listCopyA.deleteAll { index, value in
            value == 6
        }
        
        print("delete all '6' values")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? -1)")
    }
    
    func testRemoveDuplicates() {
        var list = SortedSinglyLinkedList<Int>()
        
        list.append(1)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(0)
        list.append(20)
        list.append(5)
        list.append(5)
        
        print("list = \(list)")
        
        list.removeDuplicates()
        
        print("list without duplicates = \(list), last = \(list.last?.value ?? -1)")
        
        list = SortedSinglyLinkedList<Int>()
        
        list.append(1)
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        print("list = \(list)")
        
        list.removeDuplicates()
        
        print("list without duplicates = \(list), last = \(list.last?.value ?? -1)")
    }
    
    func testMerge() {
        var listA = SortedSinglyLinkedList<Int>()
        
        listA.append(0)
        listA.append(2)
        listA.append(4)
        
        var listB = SortedSinglyLinkedList<Int>()
        
        listB.append(-1)
        listB.append(1)
        listB.append(3)
        
        print("listA = \(listA)")
        print("listB = \(listB)")
        
        listA.merge(with: listB)
        
        print("merged lists = \(listA), last = \(listA.last?.value ?? -1)")
        
        var listC = SortedSinglyLinkedList<Int>()
        listC.append(0)
        
        print("listC = \(listA)")
        print("listD is empty")
        
        listC.merge(with: SortedSinglyLinkedList<Int>())
        
        print("merged lists = \(listC), last = \(listC.last?.value ?? -1)")
    }
}
