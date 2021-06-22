//
//  SinglyLinkedListTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

class SinglyLinkedListTests {
    func test() {
        testInsert()
        testCopy()
        testCopyAndDelete()
        testSorting()
        testRemoveDuplicates()
    }
    
    func testInsert() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("c")
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        
        list.insert("b", at: 1)
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        print("list[2] = \(list[2])")
    }
    
    func testCopy() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        let listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
    }
    
    func testCopyAndDelete() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        var listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.delete(at: 0)
        
        print("delete node at 0")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.delete(at: 1)
        
        print("delete node at 1")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
        
        listCopyA.insert("e", at: 2)
        
        print("insert 'e' at 2")
        print("listCopyA = \(listCopyA), last = \(listCopyA.last?.value ?? "")")
    }
    
    func testSorting() {
        var list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        print("list = \(list)")
        
        list.sort()
        
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        
        print("list = \(list)")
        
        list.sort()
        
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = SinglyLinkedList<Int>()
        
        list.append(4)
        list.append(1)
        list.append(2)
        list.append(3)
        
        print("list = \(list)")
        
        list.sort()
        
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
        
        list = SinglyLinkedList<Int>()
        
        list.append(4)
        
        print("list = \(list)")
        
        list.sort()
        
        print("sorted list \(list), last = \(list.last?.value ?? -1)")
    }
    
    func testRemoveDuplicates() {
        var list = SinglyLinkedList<Int>()
        
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
        
        list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(1)
        list.append(0)
        list.append(20)
        list.append(5)
        
        print("list = \(list)")
        
        list.removeDuplicates()
        
        print("list without duplicates = \(list), last = \(list.last?.value ?? -1)")
    }
}
