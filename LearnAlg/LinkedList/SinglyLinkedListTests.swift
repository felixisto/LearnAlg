//
//  SinglyLinkedListTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

class SinglyLinkedListTests {
    typealias List = SinglyLinkedList
    
    func test() {
        testInsert()
        testCopy()
        testDelete()
        testCopyAndDelete()
        testSorting()
        testRemoveDuplicates()
        testMerge()
    }
    
    func testInsert() {
        var list = List<String>()
        
        list.append("a")
        list.append("c")
        
        // Expected output: a
        print("list[0] = \(list[0])")
        
        // Expected output: c
        print("list[1] = \(list[1])")
        
        list.insert("b", at: 1)
        print("insert 'b' at index 1")
        
        // Expected output: a
        print("list[0] = \(list[0])")
        
        // Expected output: b
        print("list[1] = \(list[1])")
        
        // Expected output: c
        print("list[2] = \(list[2])")
    }
    
    func testCopy() {
        var list = List<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        let listCopyA = list.copy()
        
        // Expected output: [a, b, c, d]
        print("list = \(list)")
        
        // Expected output: [a, b, c, d], last = d
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
    }
    
    func testDelete() {
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
        var list = List<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        var listCopyA = list.copy()
        
        // Expected output: [a, b, c, d]
        print("list = \(list)")
        
        // Expected output: [a, b, c, d], last = d
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.delete(at: 0)
        
        print("delete node at 0")
        
        // Expected output: [b, c, d], last = d
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.delete(at: 1)
        
        print("delete node at 1")
        
        // Expected output: [b, d], last = d
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.insert("e", at: 2)
        
        print("insert 'e' at 2")
        
        // Expected output: [b, d, e], last = e
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
    }
    
    func testSorting() {
        var list = List<Int>()
        
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        // Expected output: [1, 0, 20, 5]
        print("list = \(list)")
        
        list.sort()
        
        // Expected output: [0, 1, 5, 20], last = 20
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = List<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        
        // Expected output: [1, 2, 3, 4]
        print("list = \(list)")
        
        list.sort()
        
        // Expected output: [1, 2, 3, 4], last = 4
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = List<Int>()
        
        list.append(4)
        list.append(1)
        list.append(2)
        list.append(3)
        
        // Expected output: [4, 1, 2, 3]
        print("list = \(list)")
        
        list.sort()
        
        // Expected output: [1, 2, 3, 4], last = 4
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = List<Int>()
        
        list.append(4)
        
        // Expected output: [4]
        print("list = \(list)")
        
        list.sort()
        
        // Expected output: [4], last = 4
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
    }
    
    func testRemoveDuplicates() {
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
